module axi_bram_reader #
(
  parameter integer AXI_DATA_WIDTH = 32,
  parameter integer AXI_ADDR_WIDTH = 32,
  parameter integer BRAM_DATA_WIDTH = 32,
  parameter integer BRAM_ADDR_WIDTH = 10
)
(
  input  wire                       aclk,
  input  wire                       aresetn,
  input  wire [AXI_ADDR_WIDTH-1:0]  s_axi_araddr,  
  input  wire                       s_axi_arvalid, 
  output wire                       s_axi_arready, 
  output wire [AXI_DATA_WIDTH-1:0]  s_axi_rdata,   
  output wire [1:0]                 s_axi_rresp,   
  output wire                       s_axi_rvalid,  
  input  wire                       s_axi_rready,  
  output wire                       bram_porta_clk,
  output wire                       bram_porta_rst,
  output wire [BRAM_ADDR_WIDTH-1:0] bram_porta_addr,
  input  wire [BRAM_DATA_WIDTH-1:0] bram_porta_rddata
);
  function integer clogb2 (input integer value);
    for(clogb2 = 0; value > 0; clogb2 = clogb2 + 1) value = value >> 1;
  endfunction
  localparam integer ADDR_LSB = clogb2(AXI_DATA_WIDTH/8 - 1);
  reg int_arready_reg, int_arready_next;
  reg int_rvalid_reg, int_rvalid_next;
  always @(posedge aclk)
  begin
    if(~aresetn)
    begin
      int_arready_reg <= 1'b0;
      int_rvalid_reg <= 1'b0;
    end
    else
    begin
      int_arready_reg <= int_arready_next;
      int_rvalid_reg <= int_rvalid_next;
    end
  end
  always @*
  begin
    int_arready_next = int_arready_reg;
    int_rvalid_next = int_rvalid_reg;
    if(s_axi_arvalid)
    begin
      int_arready_next = 1'b1;
      int_rvalid_next = 1'b1;
    end
    if(int_arready_reg)
    begin
      int_arready_next = 1'b0;
    end
    if(s_axi_rready & int_rvalid_reg)
    begin
      int_rvalid_next = 1'b0;
    end
  end
  assign s_axi_rresp = 2'd0;
  assign s_axi_arready = int_arready_reg;
  assign s_axi_rdata = bram_porta_rddata;
  assign s_axi_rvalid = int_rvalid_reg;
  assign bram_porta_clk = aclk;
  assign bram_porta_rst = ~aresetn;
  assign bram_porta_addr = s_axi_araddr[ADDR_LSB+BRAM_ADDR_WIDTH-1:ADDR_LSB];
endmodule