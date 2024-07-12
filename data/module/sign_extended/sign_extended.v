module sign_extended (
  output signed [31:0] out,
input signed [15:0] in);
assign out = in;
endmodule