module mig_7series_v2_0_qdr_phy_write_control_io #(
  parameter BURST_LEN   = 4,      
  parameter ADDR_WIDTH  = 19,     
  parameter TCQ         = 100     
)
(
  input                           clk,              
  input                           rst_clk,       
  input                           wr_cmd0,          
  input                           wr_cmd1,          
  input       [ADDR_WIDTH-1:0]    wr_addr0,         
  input       [ADDR_WIDTH-1:0]    wr_addr1,         
  input                           rd_cmd0,          
  input                           rd_cmd1,          
  input       [ADDR_WIDTH-1:0]    rd_addr0,         
  input       [ADDR_WIDTH-1:0]    rd_addr1,         
  input       [1:0]               init_rd_cmd,      
  input       [1:0]               init_wr_cmd,      
  input       [ADDR_WIDTH-1:0]    init_wr_addr0,    
  input       [ADDR_WIDTH-1:0]    init_wr_addr1,    
  input       [ADDR_WIDTH-1:0]    init_rd_addr0,    
  input       [ADDR_WIDTH-1:0]    init_rd_addr1,    
  input                           cal_done,         
  output reg  [1:0]               int_rd_cmd_n,     
  output reg  [1:0]               int_wr_cmd_n,     
  output reg  [ADDR_WIDTH-1:0]    iob_addr_rise0,   
  output reg  [ADDR_WIDTH-1:0]    iob_addr_fall0,   
  output reg  [ADDR_WIDTH-1:0]    iob_addr_rise1,   
  output reg  [ADDR_WIDTH-1:0]    iob_addr_fall1,   
  output wire [1:0]               dbg_phy_wr_cmd_n,
  output wire [ADDR_WIDTH*4-1:0]  dbg_phy_addr,    
  output wire [1:0]               dbg_phy_rd_cmd_n 
);
  wire                  mux_rd_cmd0;
  wire                  mux_rd_cmd1;
  wire                  mux_wr_cmd0;
  wire                  mux_wr_cmd1;
  wire [ADDR_WIDTH-1:0] rd_addr0_r;
  wire [ADDR_WIDTH-1:0] rd_addr1_r;
  wire [ADDR_WIDTH-1:0] wr_addr0_r;
  wire [ADDR_WIDTH-1:0] wr_addr1_r;
  reg [ADDR_WIDTH-1:0]  wr_addr1_2r;
  assign dbg_phy_wr_cmd_n = int_wr_cmd_n;
  assign dbg_phy_rd_cmd_n = int_rd_cmd_n;
  assign dbg_phy_addr     = {iob_addr_rise0, iob_addr_fall0, 
                             iob_addr_rise1, iob_addr_fall1};
  wire [ADDR_WIDTH-1:0] mv_wr_addr0 = (BURST_LEN == 4) ? {ADDR_WIDTH{1'b0}} : wr_addr0;
  wire [ADDR_WIDTH-1:0] mv_wr_addr1 = (BURST_LEN == 4) ? wr_addr0 : wr_addr1;
  wire [ADDR_WIDTH-1:0] mv_rd_addr1 = (BURST_LEN == 4) ? {ADDR_WIDTH{1'b0}} : rd_addr1;
  assign rd_addr0_r  = (cal_done) ? rd_addr0 : init_rd_addr0;
  assign rd_addr1_r  = (cal_done) ? mv_rd_addr1 : init_rd_addr1;
  assign wr_addr0_r  = (cal_done) ? mv_wr_addr0 : init_wr_addr0;
  assign wr_addr1_r  = (cal_done) ? mv_wr_addr1 : init_wr_addr1;
  always @(posedge clk) 
    begin
      wr_addr1_2r <= #TCQ wr_addr1_r;
    end
  always @ (posedge clk)
    begin
      iob_addr_rise0 <=#TCQ (BURST_LEN == 4) ? rd_addr0_r : wr_addr1_2r;
      iob_addr_fall0 <=#TCQ (BURST_LEN == 4) ? rd_addr0_r : rd_addr0_r;
      iob_addr_rise1 <=#TCQ (BURST_LEN == 4) ? wr_addr1_r : wr_addr0_r;
      iob_addr_fall1 <=#TCQ (BURST_LEN == 4) ? wr_addr1_r : rd_addr1_r;
    end
  wire mv_wr_cmd0 = (BURST_LEN == 4) ? 1'b0 : wr_cmd0;
  wire mv_wr_cmd1 = (BURST_LEN == 4) ? wr_cmd0 : wr_cmd1;
  wire mv_rd_cmd1 = (BURST_LEN == 4) ? 1'b0 : rd_cmd1;
  assign mux_rd_cmd0 = (cal_done) ? rd_cmd0 : init_rd_cmd[0];
  assign mux_rd_cmd1 = (cal_done) ? mv_rd_cmd1 : init_rd_cmd[1];
  assign mux_wr_cmd0 = (cal_done) ? mv_wr_cmd0 : init_wr_cmd[0];
  assign mux_wr_cmd1 = (cal_done) ? mv_wr_cmd1 : init_wr_cmd[1];
  always @ (posedge clk)
    begin
      if (rst_clk) begin
        int_rd_cmd_n <=#TCQ 2'b11;
        int_wr_cmd_n <=#TCQ 2'b11;
      end else begin
        int_rd_cmd_n <=#TCQ {~mux_rd_cmd1, ~mux_rd_cmd0};
        int_wr_cmd_n <=#TCQ {~mux_wr_cmd1, ~mux_wr_cmd0};
      end
    end
endmodule