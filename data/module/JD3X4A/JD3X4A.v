module JD3X4A(A1, A2, A3, B1, B2, B3, C1, C2, C3, D1, D2, 
        D3, O);
input   A1;
input   A2;
input   A3;
input   B1;
input   B2;
input   B3;
input   C1;
input   C2;
input   C3;
input   D1;
input   D2;
input   D3;
output  O;
and g0(w0, A1, A2, A3);
and g1(w4, B1, B2, B3);
and g2(w8, C1, C2, C3);
and g3(w12, D1, D2, D3);
nor g4(O, w0, w4, w8, w12);
endmodule