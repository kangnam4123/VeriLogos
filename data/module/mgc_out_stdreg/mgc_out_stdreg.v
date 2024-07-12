module mgc_out_stdreg (d, z);
  parameter integer rscid = 1;
  parameter integer width = 8;
  input    [width-1:0] d;
  output   [width-1:0] z;
  wire     [width-1:0] z;
  assign z = d;
endmodule