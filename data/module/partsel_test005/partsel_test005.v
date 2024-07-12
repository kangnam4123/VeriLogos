module partsel_test005 (
	input [31:0] din,
	input signed [4:0] n,
	output reg [31:0] dout
);
	always @(*) begin
		dout = 0;
		dout[n+1] = din[n];
	end
endmodule