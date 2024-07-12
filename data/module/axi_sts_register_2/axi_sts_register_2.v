module axi_sts_register_2 #
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
  reg int_rvalid_reg, int_rvalid_next;
  reg [AXI_DATA_WIDTH-1:0] int_rdata_reg, int_rdata_next;
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
      int_rvalid_reg <= 1'b0;
      int_rdata_reg <= {(AXI_DATA_WIDTH){1'b0}};
    end
    else
    begin
      int_rvalid_reg <= int_rvalid_next;
      int_rdata_reg <= int_rdata_next;
    end
  end
  always @*
  begin
    int_rvalid_next = int_rvalid_reg;
    int_rdata_next = int_rdata_reg;
    if(s_axi_arvalid)
    begin
      int_rvalid_next = 1'b1;
      int_rdata_next = int_data_mux[s_axi_araddr[ADDR_LSB+STS_WIDTH-1:ADDR_LSB]];
    end
    if(s_axi_rready & int_rvalid_reg)
    begin
      int_rvalid_next = 1'b0;
    end
  end
  assign s_axi_rresp = 2'd0;
  assign s_axi_arready = 1'b1;
  assign s_axi_rdata = int_rdata_reg;
  assign s_axi_rvalid = int_rvalid_reg;
  assign s_axi_awready = 1'b0;
  assign s_axi_wready = 1'b0;
  assign s_axi_bresp = 2'd0;
  assign s_axi_bvalid = 1'b0;
endmodule