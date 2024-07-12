module NOR3X1_1(A, B, C, Y);
input A, B, C;
output Y;
nor(Y, A, B, C);
endmodule