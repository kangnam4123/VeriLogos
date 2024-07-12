module hardcopyiv_b17mux21 (MO, A, B, S);
   input [16:0] A, B;
   input 	S;
   output [16:0] MO; 
   assign MO = (S == 1) ? B : A; 
endmodule