module NAND2X1_1(A, B, Y);
input A, B;
output Y;
nand(Y, A, B);
endmodule