module axi_bram_writer_1 #
(
  parameter integer AXI_DATA_WIDTH = 32,
  parameter integer AXI_ADDR_WIDTH = 16,
  parameter integer BRAM_DATA_WIDTH = 32,
  parameter integer BRAM_ADDR_WIDTH = 10
)
(
  input  wire                         aclk,
  input  wire                         aresetn,
  input  wire [AXI_ADDR_WIDTH-1:0]    s_axi_awaddr,  
  input  wire                         s_axi_awvalid, 
  output wire                         s_axi_awready, 
  input  wire [AXI_DATA_WIDTH-1:0]    s_axi_wdata,   
  input  wire [AXI_DATA_WIDTH/8-1:0]  s_axi_wstrb,   
  input  wire                         s_axi_wvalid,  
  output wire                         s_axi_wready,  
  output wire [1:0]                   s_axi_bresp,   
  output wire                         s_axi_bvalid,  
  input  wire                         s_axi_bready,  
  input  wire [AXI_ADDR_WIDTH-1:0]    s_axi_araddr,  
  input  wire                         s_axi_arvalid, 
  output wire                         s_axi_arready, 
  output wire [AXI_DATA_WIDTH-1:0]    s_axi_rdata,   
  output wire [1:0]                   s_axi_rresp,   
  output wire                         s_axi_rvalid,  
  input  wire                         s_axi_rready,  
  output wire                         bram_porta_clk,
  output wire                         bram_porta_rst,
  output wire [BRAM_ADDR_WIDTH-1:0]   bram_porta_addr,
  output wire [BRAM_DATA_WIDTH-1:0]   bram_porta_wrdata,
  output wire [BRAM_DATA_WIDTH/8-1:0] bram_porta_we
);
  function integer clogb2 (input integer value);
    for(clogb2 = 0; value > 0; clogb2 = clogb2 + 1) value = value >> 1;
  endfunction
  localparam integer ADDR_LSB = clogb2(AXI_DATA_WIDTH/8 - 1);
  reg [AXI_ADDR_WIDTH-1:0] int_awaddr_reg, int_awaddr_next;
  reg int_awready_reg, int_awready_next;
  reg [AXI_DATA_WIDTH-1:0] int_wdata_reg, int_wdata_next;
  reg [AXI_DATA_WIDTH/8-1:0] int_wstrb_reg, int_wstrb_next;
  reg int_wready_reg, int_wready_next;
  reg int_bvalid_reg, int_bvalid_next;
  wire int_awdone_wire, int_wdone_wire, int_bdone_wire;
  wire [AXI_ADDR_WIDTH-1:0] int_awaddr_wire;
  wire [AXI_DATA_WIDTH-1:0] int_wdata_wire;
  wire [AXI_DATA_WIDTH/8-1:0] int_wstrb_wire;
  always @(posedge aclk)
  begin
    if(~aresetn)
    begin
      int_awaddr_reg <= {(AXI_ADDR_WIDTH){1'b0}};
      int_awready_reg <= 1'b1;
      int_wdata_reg <= {(AXI_DATA_WIDTH){1'b0}};
      int_wstrb_reg <= {(AXI_DATA_WIDTH/8){1'b0}};
      int_wready_reg <= 1'b1;
      int_bvalid_reg <= 1'b0;
    end
    else
    begin
      int_awaddr_reg <= int_awaddr_next;
      int_awready_reg <= int_awready_next;
      int_wdata_reg <= int_wdata_next;
      int_wstrb_reg <= int_wstrb_next;
      int_wready_reg <= int_wready_next;
      int_bvalid_reg <= int_bvalid_next;
    end
  end
  assign int_awdone_wire = ~int_awready_reg | s_axi_awvalid;
  assign int_wdone_wire = ~int_wready_reg | s_axi_wvalid;
  assign int_bdone_wire = ~int_bvalid_reg | s_axi_bready;
  assign int_awaddr_wire = int_awready_reg ? s_axi_awaddr : int_awaddr_reg;
  assign int_wdata_wire = int_wready_reg ? s_axi_wdata : int_wdata_reg;
  assign int_wstrb_wire = int_wready_reg ? s_axi_wstrb : int_wstrb_reg;
  always @*
  begin
    int_awaddr_next = int_awaddr_reg;
    int_awready_next = ~int_awdone_wire | (int_wdone_wire & int_bdone_wire);
    int_wdata_next = int_wdata_reg;
    int_wstrb_next = int_wstrb_reg;
    int_wready_next = ~int_wdone_wire | (int_awdone_wire & int_bdone_wire);
    int_bvalid_next = ~int_bdone_wire | (int_awdone_wire & int_wdone_wire);
    if(int_awready_reg)
    begin
      int_awaddr_next = s_axi_awaddr;
    end
    if(int_wready_reg)
    begin
      int_wdata_next = s_axi_wdata;
      int_wstrb_next = s_axi_wstrb;
    end
  end
  assign s_axi_awready = int_awready_reg;
  assign s_axi_wready = int_wready_reg;
  assign s_axi_bresp = 2'd0;
  assign s_axi_bvalid = int_bvalid_reg;
  assign s_axi_arready = 1'b0;
  assign s_axi_rdata = {(AXI_DATA_WIDTH){1'b0}};
  assign s_axi_rresp = 2'd0;
  assign s_axi_rvalid = 1'b0;
  assign bram_porta_clk = aclk;
  assign bram_porta_rst = ~aresetn;
  assign bram_porta_addr = int_awaddr_wire[ADDR_LSB+BRAM_ADDR_WIDTH-1:ADDR_LSB];
  assign bram_porta_wrdata = int_wdata_wire;
  assign bram_porta_we = int_awdone_wire & int_wdone_wire & int_bdone_wire ? int_wstrb_wire : {(BRAM_DATA_WIDTH/8){1'b0}};
endmodule