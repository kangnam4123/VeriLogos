module OAI21X1_1(A, B, C, Y);
input A, B, C;
output Y;
wire tmp;
or(tmp, A, B);
nand(Y, tmp, C);
endmodule