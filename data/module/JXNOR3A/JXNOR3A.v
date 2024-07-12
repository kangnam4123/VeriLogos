module JXNOR3A(A1, A2, A3, O);
input   A1;
input   A2;
input   A3;
output  O;
xnor g0(O, A1, A2, A3);
endmodule