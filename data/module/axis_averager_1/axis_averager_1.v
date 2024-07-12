module axis_averager_1 #
(
  parameter integer AXIS_TDATA_WIDTH = 32,
  parameter integer BRAM_DATA_WIDTH = 32,
  parameter integer BRAM_ADDR_WIDTH = 16,  
  parameter integer AVERAGES_WIDTH = 32
)
(
  input  wire                        aclk,
  input  wire                        aresetn,
  input  wire						 trig,
  input  wire 						 user_reset,
  input  wire [15:0]				 nsamples,
  input  wire [AVERAGES_WIDTH-1:0] 	 naverages,
  output wire 						 finished,
  output wire [AVERAGES_WIDTH-1:0] 	 averages_out,
  output wire                        s_axis_tready,
  input  wire [AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire                        s_axis_tvalid,
  output wire                        bram_porta_clk,
  output wire                        bram_porta_rst,
  output wire [BRAM_ADDR_WIDTH-1:0]  bram_porta_addr,
  output wire [BRAM_DATA_WIDTH-1:0]  bram_porta_wrdata,
  input  wire [BRAM_DATA_WIDTH-1:0]  bram_porta_rddata,
  output wire                        bram_porta_we,
  output wire                        bram_portb_clk,
  output wire                        bram_portb_rst,
  output wire [BRAM_ADDR_WIDTH-1:0]  bram_portb_addr,
  output wire [BRAM_DATA_WIDTH-1:0]  bram_portb_wrdata,
  input  wire [BRAM_DATA_WIDTH-1:0]  bram_portb_rddata,
  output wire                        bram_portb_we
);
  reg [BRAM_ADDR_WIDTH-1:0] int_addrA_reg, int_addrA_next;
  reg [BRAM_ADDR_WIDTH-1:0] int_addrB_reg, int_addrB_next;
  reg [2:0] int_case_reg, int_case_next;
  reg int_wren_reg, int_wren_next;
  reg [AVERAGES_WIDTH-1:0] int_averages_reg, int_averages_next;
  reg int_finished_reg, int_finished_next;
  reg [BRAM_DATA_WIDTH-1:0] int_data_reg, int_data_next;
  reg d_trig;
  wire trigger;  
  assign s_axis_tready = 1;
  assign finished = int_finished_reg;
  assign averages_out = int_averages_reg;
  assign bram_porta_clk = aclk;
  assign bram_porta_rst = ~aresetn;
  assign bram_porta_addr = int_addrA_reg;
  assign bram_porta_wrdata = int_data_reg;
  assign bram_porta_we = int_wren_reg;
  assign bram_portb_clk = aclk;
  assign bram_portb_rst = ~aresetn;
  assign bram_portb_addr = int_addrB_reg;
  assign bram_portb_wrdata = {(BRAM_DATA_WIDTH){1'b0}};
  assign bram_portb_we = 1'b0;
  always@(posedge aclk) begin
	 if (user_reset) d_trig <= 0;
	 else d_trig <= trig;
  end
  assign trigger = (trig == 1) && (d_trig == 0) ? 1 : 0;
  always @(posedge aclk)
  begin
    if(~aresetn || user_reset)
    begin
      int_addrA_reg <= {(BRAM_ADDR_WIDTH){1'b0}};
	  int_addrB_reg <= {(BRAM_ADDR_WIDTH){1'b0}};
      int_case_reg <= 3'd0;
	  int_averages_reg <= {(AVERAGES_WIDTH){1'b0}};
      int_wren_reg <= 1'b0;
      int_data_reg <= {(BRAM_DATA_WIDTH){1'b0}};
      int_finished_reg <= 1'b0;
    end
    else
    begin
      int_addrA_reg <= int_addrA_next;
      int_addrB_reg <= int_addrB_next;
      int_case_reg <= int_case_next;
      int_wren_reg <= int_wren_next;
	  int_averages_reg <= int_averages_next;
	  int_data_reg <= int_data_next;
	  int_finished_reg <= int_finished_next;
    end
  end
  always @*
  begin
    int_addrA_next = int_addrA_reg;
	int_addrB_next = int_addrB_reg;
    int_case_next = int_case_reg;
    int_wren_next = int_wren_reg;
	int_averages_next = int_averages_reg;
	int_data_next = int_data_reg;
	int_finished_next = int_finished_reg;
    case(int_case_reg)
      0:    
      begin
        int_addrA_next = {(BRAM_ADDR_WIDTH){1'b0}};
		int_addrB_next = {(BRAM_ADDR_WIDTH){1'b0}};
		int_averages_next = {(AVERAGES_WIDTH){1'b0}};
		int_case_next = 3'd1;
		int_wren_next = 1'b1;
		int_finished_next = 1'b0;
		int_data_next = {(BRAM_DATA_WIDTH){1'b0}};
      end
      1:    
      begin
        int_addrA_next = int_addrA_reg + 1'b1;
        if(int_addrA_reg == nsamples-1) 
        begin
          int_case_next = 3'd2;
		  int_wren_next = 1'b0;
        end
      end
      2:    
      begin
        int_addrA_next = -2;
        int_addrB_next = 0;
        int_wren_next = 1'b0;
        if(trigger)
        begin
		  int_averages_next = int_averages_reg + 1;
		  if (int_averages_reg == naverages)
			 int_case_next = 3'd4;
		  else
			 int_case_next = 3'd3;          
        end
      end
	  3:    
      begin
        if(s_axis_tvalid)
        begin
          int_addrA_next = int_addrA_reg + 1;
		  int_addrB_next = int_addrB_reg + 1;
		  int_data_next = bram_portb_rddata + s_axis_tdata;
		  int_wren_next = 1'b1;
		  if (int_addrA_reg == nsamples-2)
			 int_case_next = 3'd2;
        end
		else
		  int_wren_next = 1'b0;
      end
      4:	
      begin
        int_finished_next = 1;
      end
    endcase
  end
endmodule