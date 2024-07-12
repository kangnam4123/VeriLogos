module HalfAdder_2 (A, B, Sum, Carry) ; 
input A, B; 
output Sum, Carry;
assign #2 Sum = A ^ B;
assign #5 Carry = A & B;
endmodule