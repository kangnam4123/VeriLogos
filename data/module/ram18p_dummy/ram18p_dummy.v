module  ram18p_dummy
#(
  parameter integer LOG2WIDTH_RD = 4   
 )
   (
      output [(9 << (LOG2WIDTH_RD-3))-1:0] data_out 
   );
   assign data_out=0;
endmodule