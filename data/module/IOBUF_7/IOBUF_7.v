module IOBUF_7 (O, IO, I, OEN);
  input I,OEN;
  output O;
  inout IO;
  assign IO = OEN ? I : 1'bz;
  assign I = IO;
endmodule