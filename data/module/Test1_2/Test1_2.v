module Test1_2 (output [7:0] au);
   wire [7:0] 		b;
   wire signed [3:0] 	c;
   assign c=-1;  
   assign b=3;   
   assign au=b+c; 
endmodule