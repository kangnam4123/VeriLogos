module LNQD1PO4 (
  D
 ,EN
 ,Q
 );
input D ;
input EN ;
output Q ;
reg Q;
always @(negedge EN)
    Q <= D;
endmodule