module param_1 #(parameter width = 32) (
  output reg [31:0] pa_out,
  output wire [31:0] ca_out,
  input [width-1:0] in);
  wire z_pad = 1'bz;
  wire x_pad = 1'bx;
  assign ca_out = {{32-width{z_pad}}, in};
  always @* pa_out = {{32-width{x_pad}}, in};
endmodule