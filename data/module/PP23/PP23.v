module PP23(S, C, PASS, P0, P1);
input   S;
input   C;
input   PASS;
output  P0;
output  P1;
and g0(P0, S, PASS);
and g1(P1, C, PASS);
endmodule