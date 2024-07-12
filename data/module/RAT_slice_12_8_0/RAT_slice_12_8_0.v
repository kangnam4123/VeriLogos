module RAT_slice_12_8_0
   (Din,
    Dout);
  input [17:0]Din;
  output [4:0]Dout;
  wire [17:0]Din;
  assign Dout[4:0] = Din[7:3];
endmodule