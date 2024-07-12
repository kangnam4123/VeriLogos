module fmrv32im_axi_gpio_ls
(
   input         ARESETN,
   input         ACLK,
   input [15:0]  S_AXI_AWADDR,
   input [3:0]   S_AXI_AWCACHE,
   input [2:0]   S_AXI_AWPROT,
   input         S_AXI_AWVALID,
   output        S_AXI_AWREADY,
   input [31:0]  S_AXI_WDATA,
   input [3:0]   S_AXI_WSTRB,
   input         S_AXI_WVALID,
   output        S_AXI_WREADY,
   output        S_AXI_BVALID,
   input         S_AXI_BREADY,
   output [1:0]  S_AXI_BRESP,
   input [15:0]  S_AXI_ARADDR,
   input [3:0]   S_AXI_ARCACHE,
   input [2:0]   S_AXI_ARPROT,
   input         S_AXI_ARVALID,
   output        S_AXI_ARREADY,
   output [31:0] S_AXI_RDATA,
   output [1:0]  S_AXI_RRESP,
   output        S_AXI_RVALID,
   input         S_AXI_RREADY,
   output        LOCAL_CS,
   output        LOCAL_RNW,
   input         LOCAL_ACK,
   output [31:0] LOCAL_ADDR,
   output [3:0]  LOCAL_BE,
   output [31:0] LOCAL_WDATA,
   input [31:0]  LOCAL_RDATA
  );
   localparam S_IDLE   = 2'd0;
   localparam S_WRITE  = 2'd1;
   localparam S_WRITE2 = 2'd2;
   localparam S_READ   = 2'd3;
   reg [1:0]     state;
   reg           reg_rnw;
   reg [15:0]    reg_addr;
   reg [31:0]    reg_wdata;
   reg [3:0]     reg_be;
   always @( posedge ACLK or negedge ARESETN ) begin
      if( !ARESETN ) begin
         state     <= S_IDLE;
         reg_rnw   <= 1'b0;
         reg_addr  <= 16'd0;
         reg_wdata <= 32'd0;
         reg_be    <= 4'd0;
      end else begin
         case( state )
           S_IDLE: begin
              if( S_AXI_AWVALID ) begin
                 reg_rnw   <= 1'b0;
                 reg_addr  <= S_AXI_AWADDR;
                 state     <= S_WRITE;
              end else if( S_AXI_ARVALID ) begin
                 reg_rnw   <= 1'b1;
                 reg_addr  <= S_AXI_ARADDR;
                 state     <= S_READ;
              end
           end
           S_WRITE: begin
              if( S_AXI_WVALID ) begin
                 state     <= S_WRITE2;
                 reg_wdata <= S_AXI_WDATA;
                 reg_be    <= S_AXI_WSTRB;
              end
           end
           S_WRITE2: begin
              if( LOCAL_ACK & S_AXI_BREADY ) begin
                 state     <= S_IDLE;
              end
           end
           S_READ: begin
              if( LOCAL_ACK & S_AXI_RREADY ) begin
                 state     <= S_IDLE;
              end
           end
           default: begin
              state        <= S_IDLE;
           end
         endcase
      end
   end
   assign LOCAL_CS       = (( state == S_WRITE2 )?1'b1:1'b0) | (( state == S_READ )?1'b1:1'b0) | 1'b0;
   assign LOCAL_RNW      = reg_rnw;
   assign LOCAL_ADDR     = reg_addr;
   assign LOCAL_BE       = reg_be;
   assign LOCAL_WDATA    = reg_wdata;
   assign S_AXI_AWREADY  = ( state == S_WRITE || state == S_IDLE )?1'b1:1'b0;
   assign S_AXI_WREADY   = ( state == S_WRITE || state == S_IDLE )?1'b1:1'b0;
   assign S_AXI_BVALID   = ( state == S_WRITE2 )?LOCAL_ACK:1'b0;
   assign S_AXI_BRESP    = 2'b00;
   assign S_AXI_ARREADY  = ( state == S_READ  || state == S_IDLE )?1'b1:1'b0;
   assign S_AXI_RVALID   = ( state == S_READ )?LOCAL_ACK:1'b0;
   assign S_AXI_RRESP    = 2'b00;
   assign S_AXI_RDATA    = ( state == S_READ )?LOCAL_RDATA:32'd0;
endmodule