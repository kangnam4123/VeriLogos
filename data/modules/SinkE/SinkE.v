module SinkE(
  output       io_resp_valid,
  output [3:0] io_resp_bits_sink,
  input        io_e_valid,
  input  [3:0] io_e_bits_sink
);
  assign io_resp_valid = io_e_valid; 
  assign io_resp_bits_sink = io_e_bits_sink; 
endmodule