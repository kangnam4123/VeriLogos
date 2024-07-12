module sw_mux (
    port_out,
    default_port,
    alt_port,
    switch
);
  output port_out;
  input default_port;
  input alt_port;
  input switch;
  assign port_out = switch ? alt_port : default_port;
endmodule