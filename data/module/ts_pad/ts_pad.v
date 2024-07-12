module ts_pad (
  inout wire pad,
  input wire oe,
  input wire op
);
assign pad = oe ? op : 1'bz;
endmodule