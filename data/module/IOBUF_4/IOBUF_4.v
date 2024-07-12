module IOBUF_4 (O, IO, I, OEN);
  input I,OEN;
  output O;
  inout IO;
  assign IO = OEN ? 1'bz : I;
  assign I = IO;
endmodule