module delay_11 #
(
	parameter N = 8,
	parameter DELAY = 0
)
(
	input [N - 1:0] d,
	input ce,
	input clk,
	output [N - 1:0] q
);
wire [N - 1:0] tdata [DELAY:0];
assign tdata[0] = d; 
genvar i;
generate
	for(i = 0; i < DELAY; i = i + 1)
	begin: regs
	register #
	(
		.N(N)
	)
	reg_i
	(
		.clk(clk),
		.ce(ce),
		.d(tdata[i]),
		.q(tdata[i + 1])
	);
	end
endgenerate
assign q = tdata[DELAY];
endmodule