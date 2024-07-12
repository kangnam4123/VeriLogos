module mux_out #(parameter d_width = 32)
	(	output reg[d_width-1:0]out,
		input [d_width-1:0]a, b,
		input sel);
	always @(a,b,sel) begin
		if (sel)
			out <= a;
		else
			out <= b;
	end
endmodule