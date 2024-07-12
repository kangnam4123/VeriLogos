module  ram_dummy
#(
  parameter integer LOG2WIDTH_RD = 5   
 )
   (
      output [(1 << LOG2WIDTH_RD)-1:0] data_out 
   );
   assign data_out=0;
endmodule