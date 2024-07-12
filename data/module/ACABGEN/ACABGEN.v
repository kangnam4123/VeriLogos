module ACABGEN(CLK, ENB, CLK_A, CLK_B);
input   CLK;
input   ENB;         
output  CLK_A;       
output  CLK_B;       
wire pulse, dly_pulse;
not	g1(enb_, ENB);
nor    	g2(pulse, enb_,CLK);
buf  #5 g3(dly_pulse, pulse);
nand    g5(clka_, pulse,dly_pulse);
not     g6(CLK_A, clka_);
nor     g8(clkb_, pulse,dly_pulse);
not     g9(CLK_B, clkb_);
endmodule