module PP21(X0, X1, Y2, Y3, S, C, PASS, P0, P1, P2, P3);
input   X0;
input   X1;
input   Y2;
input   Y3;
input   S;
input   C;
input   PASS;
output  P0;
output  P1;
output  P2;
output  P3;
nor g0(P0, X0, Y3);
nor g1(P1, X1, Y2);
and g2(P2, S, PASS);
and g3(P3, C, PASS);
endmodule