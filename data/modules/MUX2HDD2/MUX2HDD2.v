module MUX2HDD2 (
  I0
 ,I1
 ,S
 ,Z
 );
input I0 ;
input I1 ;
input S ;
output Z ;
assign Z = S ? I1 : I0;
endmodule