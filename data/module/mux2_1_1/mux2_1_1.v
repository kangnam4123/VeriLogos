module mux2_1_1(a, b, select, out);
	input a, b, select;
	output out;
	wire not_select, out;
	wire [1:0] inter_out;
	not(not_select, select);
	and(inter_out[0], not_select, a);
	and(inter_out[1], select, b);
	or(out, inter_out[0], inter_out[1]);
endmodule