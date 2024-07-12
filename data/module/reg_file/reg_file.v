module reg_file
	#(parameter d_width = 32, reg_ct = 32, ra_width = $clog2(reg_ct) )
	(	output reg[d_width-1:0] ra, rb,
		input [d_width-1:0] rd,
		input [ra_width-1:0] addr_a, addr_b, addr_d,
		input clk);
	reg [d_width-1:0] regs[reg_ct-1:0];
	always @(negedge clk) begin
		regs[addr_d] <= rd;
	end
	always @(posedge clk) begin
		ra <= regs[addr_a];
		rb <= regs[addr_b];
	end
endmodule