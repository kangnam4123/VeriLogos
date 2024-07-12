module overflow_1 (Cout, V, g, p, c31, Cin);
  output Cout, V;
  input g, p, c31, Cin;
  assign Cout = g|(p&Cin);
  assign V = Cout^c31;
endmodule