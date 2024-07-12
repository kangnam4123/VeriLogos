module Dflop_1 (Clk, D, Q);
  input Clk, D;
  output Q;
  wire S, R;
  assign S = D;
  assign R = ~D;
  wire R_g, S_g, Qa, Qb ; 
	assign S_g = S & Clk;
	assign R_g = R & Clk;
	assign Qa = ~(R_g | Qb);
	assign Qb = ~(S_g | Qa);
	assign Q = Qa;
endmodule