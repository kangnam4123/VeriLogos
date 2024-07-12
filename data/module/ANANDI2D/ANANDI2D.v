module ANANDI2D(A1, A2, O);
input   A1;
input   A2;
output  O;
not g0(w1, A2);
nand g1(O, A1, w1);
endmodule