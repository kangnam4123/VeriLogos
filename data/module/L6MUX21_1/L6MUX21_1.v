module L6MUX21_1 (input D0, D1, SD, output Z);
	assign Z = SD ? D1 : D0;
endmodule