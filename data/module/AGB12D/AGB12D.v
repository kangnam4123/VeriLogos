module AGB12D(A1, A2, B, O);
input   A1;
input   A2;
input   B;
output  O;
or g0(w0, A1, A2);
and g1(O, w0, B);
endmodule