module JNAND2A(A1, A2, O);
input   A1;
input   A2;
output  O;
nand g0(O, A1, A2);
endmodule