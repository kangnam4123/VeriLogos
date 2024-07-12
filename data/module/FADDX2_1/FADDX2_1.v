module FADDX2_1 (A,B,CI,S,CO);
output  S,CO;
input   A,B,CI;
wire nCI, nA, nB, aq1, aq2, aq3, aq4, aq5, aq6, aq7;
not (nCI, CI);
not (nA, A);
not (nB, B);
and (aq1, nCI, nB, A);
and (aq2, nCI, B, nA);
and (aq3, CI, nA, nB);
and (aq4, CI, B, A);
and (aq5, nCI, B, A);
and (aq6, CI, nB, A);
and (aq7, CI, B, nA);
or (S, aq1, aq2, aq3, aq4);
or (CO, aq4, aq5, aq6, aq7);
endmodule