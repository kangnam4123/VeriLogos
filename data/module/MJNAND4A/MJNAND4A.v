module MJNAND4A(A1, A2, A3, A4, O);
input   A1;
input   A2;
input   A3;
input   A4;
output  O;
nand g0(O, A1, A2, A3, A4);
endmodule