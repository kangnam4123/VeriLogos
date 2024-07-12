module alt_ifconv #(
  parameter   WIDTH = 1,
  parameter   INTERFACE_NAME_IN = "input-interface-name",
  parameter   INTERFACE_NAME_OUT = "output-interface-name",
  parameter   SIGNAL_NAME_IN = "input-signal-name",
  parameter   SIGNAL_NAME_OUT = "output-signal-name") (
  input   [(WIDTH-1):0]  din,
  output  [(WIDTH-1):0]  dout);
  assign dout = din;
endmodule