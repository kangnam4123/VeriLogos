module AOI21X1_1(A, B, C, Y);
input A, B, C;
output Y;
wire tmp;
and(tmp, A, B);
nor(Y, tmp, C);
endmodule