module OAI22X1_1(A, B, C, D, Y);
input A, B, C, D;
output Y;
wire tmp0, tmp1;
or(tmp0, A, B);
or(tmp1, C, D);
nand(Y, tmp0, tmp1);
endmodule