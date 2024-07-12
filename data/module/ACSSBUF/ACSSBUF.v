module ACSSBUF(SS_CLK_UNBUF, SS_CLK_BUF1, SS_CLK_BUF2, SS_CLK_BUF3, 
        SS_CLK_BUF4, SS_CLK_BUF5, SS_CLK_BUF6, SS_CLK_BUF7, 
        SS_CLK_BUF8);
input   SS_CLK_UNBUF;
output  SS_CLK_BUF1;
output  SS_CLK_BUF2;
output  SS_CLK_BUF3;
output  SS_CLK_BUF4;
output  SS_CLK_BUF5;
output  SS_CLK_BUF6;
output  SS_CLK_BUF7;
output  SS_CLK_BUF8;
buf g0(SS_CLK_BUF1, SS_CLK_UNBUF);
buf g1(SS_CLK_BUF2, SS_CLK_UNBUF);
buf g2(SS_CLK_BUF3, SS_CLK_UNBUF);
buf g3(SS_CLK_BUF4, SS_CLK_UNBUF);
buf g4(SS_CLK_BUF5, SS_CLK_UNBUF);
buf g5(SS_CLK_BUF6, SS_CLK_UNBUF);
buf g6(SS_CLK_BUF7, SS_CLK_UNBUF);
buf g7(SS_CLK_BUF8, SS_CLK_UNBUF);
endmodule