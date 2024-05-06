module Mux_0xdd6473406d1a99a
(
  input  wire [   0:0] clock,
  input  wire [  15:0] in_$000,
  input  wire [  15:0] in_$001,
  output reg  [  15:0] out,
  input  wire [   0:0] reset,
  input  wire [   0:0] sel
);
  localparam nports = 2;
  wire   [  15:0] in_[0:1];
  assign in_[  0] = in_$000;
  assign in_[  1] = in_$001;
  always @ (*) begin
    out = in_[sel];
  end
endmodule