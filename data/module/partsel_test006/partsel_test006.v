module partsel_test006 (
	input [31:-32] din,
	input signed [4:0] n,
	output reg [31:-32] dout
);
	always @(*) begin
		dout = 0;
		dout[n+1 +: 2] = din[n +: 2];
	end
endmodule