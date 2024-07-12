module stratixiigx_b5mux21 (MO, A, B, S);
   input [4:0] A, B;
   input       S;
   output [4:0] MO; 
   assign MO = (S == 1) ? B : A; 
endmodule