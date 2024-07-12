module full_adder_1bit_struct
  (
   input                     Ain,
   input                     Bin,
   input                     Cin,
   output                    Sum,
   output                    Cout
  );
  assign Sum  = Ain ^ Bin ^ Cin;
  assign Cout = (Ain & Bin) | (Bin & Cin) | (Cin & Ain);
endmodule