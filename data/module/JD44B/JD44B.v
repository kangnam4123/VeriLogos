module JD44B(A1, A2, A3, A4, B1, B2, B3, B4, O);
input   A1;
input   A2;
input   A3;
input   A4;
input   B1;
input   B2;
input   B3;
input   B4;
output  O;
and g0(w0, A1, A2, A3, A4);
and g1(w5, B1, B2, B3, B4);
nor g2(O, w0, w5);
endmodule