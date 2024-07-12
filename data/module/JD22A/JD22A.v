module JD22A(A1, A2, B1, B2, O);
input   A1;
input   A2;
input   B1;
input   B2;
output  O;
and g0(w0, A1, A2);
and g1(w3, B1, B2);
nor g2(O, w0, w3);
endmodule