module mux_4bit_2to1 (s, U, V, M);
  input s;
  input [3:0] U, V;
  output [3:0] M;
  assign M = ({4{~s}} & U) | ({4{s}} & V);
endmodule