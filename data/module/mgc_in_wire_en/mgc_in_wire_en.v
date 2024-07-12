module mgc_in_wire_en (ld, d, lz, z);
  parameter integer rscid = 1;
  parameter integer width = 8;
  input              ld;
  output [width-1:0] d;
  output             lz;
  input  [width-1:0] z;
  wire   [width-1:0] d;
  wire               lz;
  assign d = z;
  assign lz = ld;
endmodule