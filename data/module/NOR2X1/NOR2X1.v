module NOR2X1(A, B, Y);
input A, B;
output Y;
nor(Y, A, B);
endmodule