module MJG112A(A1, A2, B1, B2, O);
input   A1;
input   A2;
input   B1;
input   B2;
output  O;
or g0(w0, A1, A2);
nand g1(O, w0, B1, B2);
endmodule