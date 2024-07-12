module JD444A(A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, 
        C4, O);
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
output  O;
and g0(w0, A1, A2, A3, A4);
and g1(w5, B1, B2, B3, B4);
and g2(w10, C1, C2, C3, C4);
nor g3(O, w0, w5, w10);
endmodule