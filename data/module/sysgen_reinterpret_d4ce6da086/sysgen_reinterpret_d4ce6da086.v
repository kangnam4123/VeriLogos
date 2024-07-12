module sysgen_reinterpret_d4ce6da086 (
  input [(34 - 1):0] input_port,
  output [(34 - 1):0] output_port,
  input clk,
  input ce,
  input clr);
  wire signed [(34 - 1):0] input_port_1_40;
  wire [(34 - 1):0] output_port_5_5_force;
  assign input_port_1_40 = input_port;
  assign output_port_5_5_force = input_port_1_40;
  assign output_port = output_port_5_5_force;
endmodule