module JD4232A(A1, A2, A3, A4, B1, B2, C1, C2, C3, D1, D2, 
        O);
input   A1;
input   A2;
input   A3;
input   A4;
input   B1;
input   B2;
input   C1;
input   C2;
input   C3;
input   D1;
input   D2;
output  O;
and g0(w0, A1, A2, A3, A4);
and g1(w5, B1, B2);
and g2(w8, C1, C2, C3);
and g3(w12, D1, D2);
nor g4(O, w0, w5, w8, w12);
endmodule