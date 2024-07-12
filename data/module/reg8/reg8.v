module reg8(
	input clk,
	input ce,
	input [7:0] in,
	output [7:0] out);
	reg [8:0] register;
	initial register = 8'h00;
	assign out = register;
	always @(posedge clk) begin
		if(ce) begin
			register = in;
		end
	end
endmodule