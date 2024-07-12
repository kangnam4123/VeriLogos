module full_sub_1bit_struct
  (
   input                     Xin,
   input                     Yin,
   input                     BorrowIn,
   output                    Diff,
   output                    BorrowOut 
  );
  assign Diff      = Xin ^ Yin ^ BorrowIn;
  assign BorrowOut = (~Xin & Yin) | (~Xin & BorrowIn) | (Yin & BorrowIn);
endmodule