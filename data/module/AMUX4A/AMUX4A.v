module AMUX4A(I1, I2, I3, I4, S0, S1, O);
input   I1;
input   I2;
input   I3;
input   I4;
input   S0;
input   S1;
output  O;
not g0(w2, S0);
not g1(w3, S1);
and g2(w0, I1, w2, w3);
not g3(w7, S1);
and g4(w4, I2, S0, w7);
not g5(w10, S0);
and g6(w8, I3, w10, S1);
and g7(w12, I4, S0, S1);
or g8(O, w0, w4, w8, w12);
endmodule