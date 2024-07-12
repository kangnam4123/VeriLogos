module NAND3X1_1(A, B, C, Y);
input A, B, C;
output Y;
nand(Y, A, B, C);
endmodule