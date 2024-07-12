module parity_gen_1bit_struct
  (
   input                     Ain,
   input                     Bin,
   output                    ParityOut 
  );
  assign ParityOut = (~Ain & Bin) | (Ain & ~Bin);
endmodule