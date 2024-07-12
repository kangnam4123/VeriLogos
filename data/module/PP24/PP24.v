module PP24(X, Y, S, C, PASS, P0, P1, P2);
input   X;
input   Y;
input   S;
input   C;
input   PASS;
output  P0;
output  P1;
output  P2;
nor g0(P0, X, Y);
and g1(P1, S, PASS);
and g2(P2, C, PASS);
endmodule