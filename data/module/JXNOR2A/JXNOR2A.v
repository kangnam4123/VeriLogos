module JXNOR2A(A1, A2, O);
input   A1;
input   A2;
output  O;
xnor g0(O, A1, A2);
endmodule