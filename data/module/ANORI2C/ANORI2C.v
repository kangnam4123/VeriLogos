module ANORI2C(A1, A2, O);
input   A1;
input   A2;
output  O;
not g0(w1, A2);
nor g1(O, A1, w1);
endmodule