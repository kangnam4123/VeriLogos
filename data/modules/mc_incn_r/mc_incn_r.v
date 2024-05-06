module mc_incn_r(clk, inc_in, inc_out);
parameter	incN_width = 32;
input		clk;
input	[incN_width-1:0]	inc_in;
output	[incN_width-1:0]	inc_out;
parameter	incN_center = incN_width / 2;
reg	[incN_center:0]		out_r;
wire	[31:0]			tmp_zeros = 32'h0;
wire	[incN_center-1:0]	inc_next;
always @(posedge clk)
	out_r <= #1 inc_in[incN_center - 1:0] + {tmp_zeros[incN_center-2:0], 1'h1};
assign inc_out[incN_width-1:incN_center] = inc_in[incN_width-1:incN_center] + inc_next;
assign inc_next = out_r[incN_center] ?
			{tmp_zeros[incN_center-2:0], 1'h1} : tmp_zeros[incN_center-2:0];
assign inc_out[incN_center-1:0]  = out_r;
endmodule