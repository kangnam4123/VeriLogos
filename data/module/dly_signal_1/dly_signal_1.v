module dly_signal_1 #(
  parameter WIDTH = 1
)(
  input  wire             clk,
  input  wire [WIDTH-1:0] indata,
  output reg  [WIDTH-1:0] outdata
);
  always @(posedge clk) outdata <= indata;
endmodule