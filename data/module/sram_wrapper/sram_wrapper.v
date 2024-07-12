module sram_wrapper
(
	input wire		          		clk,
	input wire						aresetn,
	input wire						wen,
	input wire			[19:0]		addr,
	input wire			[15:0]		din,
	output wire			[15:0]		dout,
	output wire	    	[19:0]		SRAM_ADDR,
	output wire		          		SRAM_CE_N,
	inout  wire		    [15:0]		SRAM_DQ,
	output wire		          		SRAM_LB_N,
	output wire		          		SRAM_OE_N,
	output wire		          		SRAM_UB_N,
	output wire		          		SRAM_WE_N
);
reg [15:0]	a;
reg [15:0]	b;
reg  		wen_latch;
reg [19:0]	addr_latch;
wire 		output_enable;
always @(posedge clk) wen_latch  <= wen;
always @(posedge clk) addr_latch <= addr;
assign output_enable = ~wen_latch;
always @(posedge clk) begin
	a <= din;
	b <= SRAM_DQ;
end
assign SRAM_DQ   = ~output_enable ? a : 16'bZ;
assign dout 	 = b;
assign SRAM_WE_N = ~wen_latch;
assign SRAM_CE_N = ~aresetn;
assign SRAM_OE_N = ~output_enable;
assign SRAM_LB_N = 1'b0;
assign SRAM_UB_N = 1'b0;
assign SRAM_ADDR = addr_latch;
endmodule