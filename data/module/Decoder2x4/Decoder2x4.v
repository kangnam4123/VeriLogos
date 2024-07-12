module Decoder2x4 (A, B, EN, Z);
input A, B, EN;
output [0 :3] Z;
wire Abar, Bbar;
assign #1 Abar = ~ A; 
assign #1 Bbar = ~ B; 
assign #2 Z[0] = ~ (Abar & Bbar & EN ) ; 
assign #2 Z[1] = ~ (Abar & B & EN) ; 
assign #2 Z[2] = ~ (A & Bbar & EN) ; 
assign #2 Z[3] = ~ ( A & B & EN) ; 
endmodule