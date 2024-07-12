module negedgedet(
	input clk,
	input in,
	output out);
	reg outreg;
	reg [3:0] sr;
	initial sr = 4'b0000;
	assign out = outreg;
	always @(*) begin
		outreg = 0;
		if((sr[2] == 0) && (sr[3] == 1))
			outreg = 1;
	end
	always @(posedge clk) begin
		sr[3] <= sr[2];
		sr[2] <= sr[1];
		sr[1] <= sr[0];
		sr[0] <= in;
	end
endmodule