module ACALLBUF(SS_CLK, RFR_CLK, RFR_LATE, RCC_CLK,
        SBOCLK, PCI_CLK, GCLK, SS_CLK_T, SS_CLK_L, SS_CLK_B, 
        SS_CLK_R, RFR_CLK_D, RFR_LATE_D, GCLK_I, REF_CLK_I, 
	SBOCLK_S, PCI_CLK_I, RCC_CLK_M);
input   SS_CLK;
input   RFR_CLK;
input   RFR_LATE;
input   RCC_CLK;
input   SBOCLK;
input	PCI_CLK;
input   GCLK;
output  SS_CLK_T;
output  SS_CLK_L;
output  SS_CLK_B;
output  SS_CLK_R;
output  RFR_CLK_D;
output  RFR_LATE_D;
output  GCLK_I;
output  REF_CLK_I;
output  SBOCLK_S;
output	PCI_CLK_I;
output  RCC_CLK_M;
buf g0(SS_CLK_T, SS_CLK);
buf g1(SS_CLK_L, SS_CLK);
buf g2(SS_CLK_B, SS_CLK);
buf g3(SS_CLK_R, SS_CLK);
buf g4(RFR_CLK_D, RFR_CLK);
buf g5(RFR_LATE_D, RFR_LATE);
buf g6(GCLK_I, GCLK);
buf g7(REF_CLK_I, SS_CLK);
buf g8(SBOCLK_S, SBOCLK);
buf g10(PCI_CLK_I, PCI_CLK);
buf g11(RCC_CLK_M, RCC_CLK);
endmodule