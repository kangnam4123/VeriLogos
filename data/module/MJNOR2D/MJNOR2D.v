module MJNOR2D(A1, A2, O);
input   A1;
input   A2;
output  O;
nor g0(O, A1, A2);
endmodule