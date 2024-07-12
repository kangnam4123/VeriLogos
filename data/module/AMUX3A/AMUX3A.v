module AMUX3A(I0, I1, I2, S0, S1, O);
input   I0;
input   I1;
input   I2;
input   S0;
input   S1;
output  O;
not g0(w2, S0);
not g1(w3, S1);
and g2(w0, I0, w2, w3);
not g3(w7, S1);
and g4(w4, I1, S0, w7);
and g5(w8, I2, S1);
or g6(O, w0, w4, w8);
endmodule