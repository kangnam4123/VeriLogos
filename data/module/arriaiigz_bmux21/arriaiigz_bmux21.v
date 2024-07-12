module arriaiigz_bmux21 (MO, A, B, S);
   input [15:0] A, B;
   input 	S;
   output [15:0] MO; 
   assign MO = (S == 1) ? B : A; 
endmodule