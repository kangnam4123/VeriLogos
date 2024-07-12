module JHAD1A(A, B, S, CO);
input   A;
input   B;
output  S;
output  CO;
xor g0(S, A, B);
and g1(CO, A, B);
endmodule