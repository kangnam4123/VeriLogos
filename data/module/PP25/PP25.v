module PP25(X0, X1, Y2, Y3, S, C, PASS, P0, P1, P2);
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
nor g0(P0, X1, Y2);
nor g1(w3, X0, Y3);
not g2(w6, PASS);
and g3(w2, w3, w6);
and g4(w7, S, PASS);
or g5(P1, w2, w7);
and g6(P2, C, PASS);
endmodule