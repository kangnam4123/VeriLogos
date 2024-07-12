module sub3_1;  
   logic [7:0] inwires [12:10] ;
   wire [7:0] outwires [12:10] ;
   assign outwires[10] = inwires[11];
   assign outwires[11] = inwires[12];
   assign outwires[12] = inwires[13];  
endmodule