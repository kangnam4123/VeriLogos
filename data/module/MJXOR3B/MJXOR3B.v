module MJXOR3B(A1, A2, A3, O);
input   A1;
input   A2;
input   A3;
output  O;
xor g0(O, A1, A2, A3);
endmodule