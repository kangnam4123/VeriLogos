module add1_3(input A, input B, input Cin, output Q, output Cout);
   assign Q = A ^ B ^ Cin;
   assign Cout = A&B | A&Cin | B&Cin;
endmodule