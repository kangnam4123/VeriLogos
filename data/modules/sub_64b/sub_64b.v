module sub_64b (dataa, datab, result);
	input [63:0] dataa;
	input [63:0] datab;
	output [63:0] result;
	assign result = dataa - datab;
endmodule