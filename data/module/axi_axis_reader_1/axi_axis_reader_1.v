module axi_axis_reader_1 #
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
  reg int_arready_reg, int_arready_next;
  reg [AXI_DATA_WIDTH-1:0] int_rdata_reg, int_rdata_next;
  reg int_rvalid_reg, int_rvalid_next;
  wire int_ardone_wire, int_rdone_wire;
  always @(posedge aclk)
  begin
    if(~aresetn)
    begin
      int_arready_reg <= 1'b1;
      int_rdata_reg <= {(AXI_DATA_WIDTH){1'b0}};
      int_rvalid_reg <= 1'b0;
    end
    else
    begin
      int_arready_reg <= int_arready_next;
      int_rdata_reg <= int_rdata_next;
      int_rvalid_reg <= int_rvalid_next;
    end
  end
  assign int_ardone_wire = ~int_arready_reg | s_axi_arvalid;
  assign int_rdone_wire = ~int_rvalid_reg | s_axi_rready;
  always @*
  begin
    int_arready_next = ~int_ardone_wire | int_rdone_wire;
    int_rdata_next = int_rdata_reg;
    int_rvalid_next = ~int_rdone_wire | int_ardone_wire;
    if(int_ardone_wire & int_rdone_wire)
    begin
      int_rdata_next = s_axis_tvalid ? s_axis_tdata : {(AXI_DATA_WIDTH){1'b0}};
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
  assign s_axis_tready = int_ardone_wire & int_rdone_wire;
endmodule