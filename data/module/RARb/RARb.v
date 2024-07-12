module RARb #(parameter n = 8)
	(r, g);
    input [n - 1 : 0] r;
    output [n - 1 : 0] g;
    wire [ n - 1  : 0 ] c = {1'b1, (~r[n-1:1] & c[n-1:1])};
    assign g = r & c;
endmodule