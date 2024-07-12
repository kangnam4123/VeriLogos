module circuitA_1 (V, A);
  input [2:0] V;
  output [2:0] A;
  assign A[0] = V[0];
  assign A[1] = ~V[1];
  assign A[2] = (V[2] & V[1]);
endmodule