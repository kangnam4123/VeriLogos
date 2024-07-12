module PP3(X0, X1, X2, Y1, Y2, Y3, P0, P1, P2);
input   X0;
input   X1;
input   X2;
input   Y1;
input   Y2;
input   Y3;
output  P0;
output  P1;
output  P2;
nor g0(P0, X0, Y3);
nor g1(P1, X1, Y2);
nor g2(P2, X2, Y1);
endmodule