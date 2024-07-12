module add8(
  input wire [7:0] input0,
  input wire [7:0] input1,
  output wire [7:0] out
);
  assign out = input0 + input1;
endmodule