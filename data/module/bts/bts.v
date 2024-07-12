module bts ( z , a , e);
  inout z ; wire z ;
  input a ; wire a ;
  input e ; wire e ;
  assign #4 z= ( (e==1'b1)? a : 1'bz );
endmodule