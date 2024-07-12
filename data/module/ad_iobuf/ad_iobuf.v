module ad_iobuf #(
  parameter     DATA_WIDTH = 1) (
  input       [(DATA_WIDTH-1):0]  dio_t,
  input       [(DATA_WIDTH-1):0]  dio_i,
  output      [(DATA_WIDTH-1):0]  dio_o,
  inout       [(DATA_WIDTH-1):0]  dio_p);
  genvar n;
  generate
  for (n = 0; n < DATA_WIDTH; n = n + 1) begin: g_iobuf
  assign dio_o[n] = dio_p[n];
  assign dio_p[n] = (dio_t[n] == 1'b1) ? 1'bz : dio_i[n];
  end
  endgenerate
endmodule