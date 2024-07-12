module f1_test_8(input [15:0] IN, input [4:0] SHIFT, output [15:0] OUT);
assign OUT = IN << SHIFT;
endmodule