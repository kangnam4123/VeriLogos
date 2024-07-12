module PP2(X0, X1, Y2, Y3, P0, P1);
input   X0;
input   X1;
input   Y2;
input   Y3;
output  P0;
output  P1;
nor g0(P0, X0, Y3);
nor g1(P1, X1, Y2);
endmodule