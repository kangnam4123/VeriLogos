module MJD2X8A(A1, A2, B1, B2, C1, C2, D1, D2, E1, E2, F1, 
        F2, G1, G2, H1, H2, O);
input   A1;
input   A2;
input   B1;
input   B2;
input   C1;
input   C2;
input   D1;
input   D2;
input   E1;
input   E2;
input   F1;
input   F2;
input   G1;
input   G2;
input   H1;
input   H2;
output  O;
and g0(w0, A1, A2);
and g1(w3, B1, B2);
and g2(w6, C1, C2);
and g3(w9, D1, D2);
and g4(w12, E1, E2);
and g5(w15, F1, F2);
and g6(w18, G1, G2);
and g7(w21, H1, H2);
nor g8(O, w0, w3, w6, w9, w12, w15, w18, w21);
endmodule