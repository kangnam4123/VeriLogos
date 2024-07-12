module axi_sts_register_1 #
(
  parameter integer STS_DATA_WIDTH = 1024,
  parameter integer AXI_DATA_WIDTH = 32,
  parameter integer AXI_ADDR_WIDTH = 16
)
(
  input  wire                      aclk,
  input  wire                      aresetn,
  input  wire [STS_DATA_WIDTH-1:0] sts_data,
  input  wire [AXI_ADDR_WIDTH-1:0] s_axi_awaddr,  
  input  wire                      s_axi_awvalid, 
  output wire                      s_axi_awready, 
  input  wire [AXI_DATA_WIDTH-1:0] s_axi_wdata,   
  input  wire                      s_axi_wvalid,  
  output wire                      s_axi_wready,  
  output wire [1:0]                s_axi_bresp,   
  output wire                      s_axi_bvalid,  
  input  wire                      s_axi_bready,  
  input  wire [AXI_ADDR_WIDTH-1:0] s_axi_araddr,  
  input  wire                      s_axi_arvalid, 
  output wire                      s_axi_arready, 
  output wire [AXI_DATA_WIDTH-1:0] s_axi_rdata,   
  output wire [1:0]                s_axi_rresp,   
  output wire                      s_axi_rvalid,  
  input  wire                      s_axi_rready   
);
  function integer clogb2 (input integer value);
    for(clogb2 = 0; value > 0; clogb2 = clogb2 + 1) value = value >> 1;
  endfunction
  localparam integer ADDR_LSB = clogb2(AXI_DATA_WIDTH/8 - 1);
  localparam integer STS_SIZE = STS_DATA_WIDTH/AXI_DATA_WIDTH;
  localparam integer STS_WIDTH = STS_SIZE > 1 ? clogb2(STS_SIZE-1) : 1;
  reg [AXI_ADDR_WIDTH-1:0] int_araddr_reg, int_araddr_next;
  reg int_arready_reg, int_arready_next;
  reg [AXI_DATA_WIDTH-1:0] int_rdata_reg, int_rdata_next;
  reg int_rvalid_reg, int_rvalid_next;
  wire int_ardone_wire, int_rdone_wire;
  wire [AXI_ADDR_WIDTH-1:0] int_araddr_wire;
  wire [AXI_DATA_WIDTH-1:0] int_data_mux [STS_SIZE-1:0];
  genvar j, k;
  generate
    for(j = 0; j < STS_SIZE; j = j + 1)
    begin : WORDS
      assign int_data_mux[j] = sts_data[j*AXI_DATA_WIDTH+AXI_DATA_WIDTH-1:j*AXI_DATA_WIDTH];
    end
  endgenerate
  always @(posedge aclk)
  begin
    if(~aresetn)
    begin
      int_araddr_reg <= {(AXI_ADDR_WIDTH){1'b0}};
      int_arready_reg <= 1'b1;
      int_rdata_reg <= {(AXI_DATA_WIDTH){1'b0}};
      int_rvalid_reg <= 1'b0;
    end
    else
    begin
      int_araddr_reg <= int_araddr_next;
      int_arready_reg <= int_arready_next;
      int_rdata_reg <= int_rdata_next;
      int_rvalid_reg <= int_rvalid_next;
    end
  end
  assign int_ardone_wire = ~int_arready_reg | s_axi_arvalid;
  assign int_rdone_wire = ~int_rvalid_reg | s_axi_rready;
  assign int_araddr_wire = int_arready_reg ? s_axi_araddr : int_araddr_reg;
  always @*
  begin
    int_araddr_next = int_araddr_reg;
    int_arready_next = ~int_ardone_wire | int_rdone_wire;
    int_rdata_next = int_rdata_reg;
    int_rvalid_next = ~int_rdone_wire | int_ardone_wire;
    if(int_arready_reg)
    begin
      int_araddr_next = s_axi_araddr;
    end
    if(int_ardone_wire & int_rdone_wire)
    begin
      int_rdata_next = int_data_mux[int_araddr_wire[ADDR_LSB+STS_WIDTH-1:ADDR_LSB]];
    end
  end
  assign s_axi_awready = 1'b0;
  assign s_axi_wready = 1'b0;
  assign s_axi_bresp = 2'd0;
  assign s_axi_bvalid = 1'b0;
  assign s_axi_arready = int_arready_reg;
  assign s_axi_rdata = int_rdata_reg;
  assign s_axi_rresp = 2'd0;
  assign s_axi_rvalid = int_rvalid_reg;
endmodule