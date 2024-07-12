module JD4X4A(A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, 
        C4, D1, D2, D3, D4, O);
input   A1;
input   A2;
input   A3;
input   A4;
input   B1;
input   B2;
input   B3;
input   B4;
input   C1;
input   C2;
input   C3;
input   C4;
input   D1;
input   D2;
input   D3;
input   D4;
output  O;
and g0(w0, A1, A2, A3, A4);
and g1(w5, B1, B2, B3, B4);
and g2(w10, C1, C2, C3, C4);
and g3(w15, D1, D2, D3, D4);
nor g4(O, w0, w5, w10, w15);
endmodule