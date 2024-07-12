module axi_axis_reader #
(
  parameter integer AXI_DATA_WIDTH = 32,
  parameter integer AXI_ADDR_WIDTH = 16
)
(
  input  wire                      aclk,
  input  wire                      aresetn,
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
  input  wire                      s_axi_rready,  
  output wire                      s_axis_tready,
  input  wire [AXI_DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                      s_axis_tvalid
);
  reg int_rvalid_reg, int_rvalid_next;
  reg [AXI_DATA_WIDTH-1:0] int_rdata_reg, int_rdata_next;
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
      int_rdata_next = s_axis_tvalid ? s_axis_tdata : {(AXI_DATA_WIDTH){1'b0}};
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
  assign s_axis_tready = s_axi_rready & int_rvalid_reg;
endmodule