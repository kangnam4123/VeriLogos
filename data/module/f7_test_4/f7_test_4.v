module f7_test_4(input [31:0] IN, input [5:0] SHIFT, output [31:0] OUT);
assign OUT = IN >> SHIFT;
endmodule