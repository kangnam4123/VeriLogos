module CC_DLT #(
	parameter [0:0] G_INV = 1'b0,
	parameter [0:0] SR_INV = 1'b0,
	parameter [0:0] SR_VAL = 1'b0
)(
	input D,
	input G,
	input SR,
	output reg Q
);
	wire en, sr;
	assign en  = (G_INV) ? ~G : G;
	assign sr  = (SR_INV) ? ~SR : SR;
	initial Q = 1'bX;
	always @(*)
	begin
		if (sr) begin
			Q <= SR_VAL;
		end
		else if (en) begin
			Q <= D;
		end
	end
endmodule