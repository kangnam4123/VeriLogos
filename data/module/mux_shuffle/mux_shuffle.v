module mux_shuffle #(
	parameter U = 2,
	parameter V = 2
) (
	input [U*V-1:0] in,
	output [V*U-1:0] out
);
	genvar u, v;
	generate
	for (u = 0; u < U; u = u + 1) begin : _U
		for (v = 0; v < V; v = v + 1) begin : _V
			assign out[v*U+u] = in[u*V+v];
		end
	end
	endgenerate
endmodule