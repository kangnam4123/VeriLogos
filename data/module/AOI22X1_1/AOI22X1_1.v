module AOI22X1_1(A, B, C, D, Y);
input A, B, C, D;
output Y;
wire tmp0, tmp1;
and(tmp0, A, B);
and(tmp1, C, D);
nor(Y, tmp0, tmp1);
endmodule