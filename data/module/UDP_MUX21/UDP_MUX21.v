module UDP_MUX21(O_, A,B, S);
output	O_;
input	A, B, S;
  assign O_ = ((~A && ~S) || (~B && S));
endmodule