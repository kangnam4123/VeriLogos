module comparator_1bit_struct
  (
   input                     Ain,
   input                     Bin,
   output                    CompOut 
  );
  assign CompOut = (~Ain & ~Bin) | (Ain & Bin);
endmodule