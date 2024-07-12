module PP26(X0, X1, X2, Y1, Y2, Y3, S, C, PASS, P0, P1, 
        P2);
input   X0;
input   X1;
input   X2;
input   Y1;
input   Y2;
input   Y3;
input   S;
input   C;
input   PASS;
output  P0;
output  P1;
output  P2;
nor g0(P0, X2, Y1);
nor g1(w3, X1, Y2);
not g2(w6, PASS);
and g3(w2, w3, w6);
and g4(w7, S, PASS);
or g5(P1, w2, w7);
nor g6(w11, X0, Y3);
not g7(w14, PASS);
and g8(w10, w11, w14);
and g9(w15, C, PASS);
or g10(P2, w10, w15);
endmodule