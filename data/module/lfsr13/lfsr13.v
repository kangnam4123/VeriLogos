module lfsr13(clk, rst, ena, state);
	input clk, rst, ena;
	output [12:0] state;
	reg [12:0] state;
	always @(posedge rst or posedge clk) begin
		if (rst == 1) begin
			state <= 1;
		end else if (ena) begin
			state[12:1] <= state[11:0];
			state[0] <= state[7] ^ state[10] ^ state[11] ^ state[12];
		end
	end
endmodule