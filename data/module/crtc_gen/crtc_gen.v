module crtc_gen( 
I_CLK, 
I_RSTn, 
I_Nht, 
I_Nhd, 
I_Nhsp, 
I_Nhsw, 
I_Nvt, 
I_Nadj, 
I_Nvd, 
I_Nvsp, 
I_Nvsw, 
I_Nr, 
I_Msa, 
O_RA, 
O_MA, 
O_H_SYNC, 
O_V_SYNC, 
O_DISPTMG 
); 
input  I_CLK; 
input  I_RSTn; 
input  [7:0]I_Nht; 
input  [7:0]I_Nhd; 
input  [7:0]I_Nhsp; 
input  [3:0]I_Nhsw; 
input  [6:0]I_Nvt; 
input  [4:0]I_Nr; 
input  [4:0]I_Nadj;  
input  [6:0]I_Nvd; 
input  [6:0]I_Nvsp; 
input  [3:0]I_Nvsw; 
input  [13:0]I_Msa; 
output [4:0]O_RA; 
output [13:0]O_MA; 
output O_H_SYNC; 
output O_V_SYNC; 
output O_DISPTMG; 
reg    [7:0]R_H_CNT; 
reg    [6:0]R_V_CNT; 
reg    [4:0]R_RA; 
reg    [13:0]R_MA; 
reg    R_H_SYNC,R_V_SYNC; 
reg    R_DISPTMG ,R_V_DISPTMG; 
reg    R_LAST_LINE; 
wire   [7:0] NEXT_R_H_CNT = (R_H_CNT+8'h01); 
wire   [6:0] NEXT_R_V_CNT = (R_V_CNT+7'h01); 
wire   [4:0] NEXT_R_RA    = R_RA + 1'b1; 
wire W_HD       = (R_H_CNT==I_Nht); 
wire W_VD       = (R_V_CNT==I_Nvt); 
wire W_ADJ_C    = R_LAST_LINE & (NEXT_R_RA==I_Nadj); 
wire W_VCNT_RET = ((R_RA==I_Nr) & (I_Nadj==0) & W_VD) | W_ADJ_C; 
wire W_RA_C     = (R_RA==I_Nr) | W_ADJ_C; 
wire   W_HSYNC_P = (NEXT_R_H_CNT == I_Nhsp); 
wire   W_HSYNC_W = (NEXT_R_H_CNT[3:0] == (I_Nhsp[3:0]+I_Nhsw) ); 
wire   W_VSYNC_P = (NEXT_R_V_CNT == I_Nvsp ) & W_RA_C; 
wire   W_VSYNC_W = (NEXT_R_RA[3:0]==I_Nvsw); 
wire W_HDISP_N   = (NEXT_R_H_CNT==I_Nhd); 
wire W_VDISP_N   = (NEXT_R_V_CNT==I_Nvd) & W_RA_C; 
assign O_H_SYNC = R_H_SYNC; 
assign O_V_SYNC = R_V_SYNC; 
assign O_RA     = R_RA; 
assign O_MA     = R_MA; 
assign O_DISPTMG = R_DISPTMG; 
reg    [13:0] R_MA_C; 
always@(negedge I_CLK or negedge I_RSTn) 
begin 
  if(! I_RSTn)begin 
    R_MA   <= 14'h0000; 
    R_MA_C <= 14'h0000; 
    R_H_CNT <= 8'h00;  
    R_H_SYNC <= 0;  
    R_RA <= 5'h00;  
    R_V_CNT <= 7'h00;  
    R_LAST_LINE <= 1'b0; 
    R_V_SYNC <= 0;  
    R_V_DISPTMG <= 1'b0; 
    R_DISPTMG   <= 1'b0; 
  end 
  else begin 
    R_H_CNT <= W_HD ? 8'h00 : NEXT_R_H_CNT; 
    R_MA <= W_HD ? R_MA_C : R_MA + 1'b1; 
    if(W_RA_C & (R_H_CNT==I_Nhd) ) 
      R_MA_C <= W_VCNT_RET ? I_Msa : R_MA; 
    if(W_HSYNC_P)      R_H_SYNC <= 1'b1; 
    else if(W_HSYNC_W) R_H_SYNC <= 1'b0; 
    if(W_HD) 
    begin 
      R_RA <= W_RA_C ? 5'h00 : NEXT_R_RA; 
      if(W_VSYNC_P) R_V_SYNC <= 1'b1; 
      else if(W_VSYNC_W) R_V_SYNC <= 1'b0; 
      if(W_RA_C) 
      begin 
        R_LAST_LINE <= W_VD; 
        R_V_CNT <= W_VCNT_RET ? 7'h00 : NEXT_R_V_CNT; 
      end 
    end 
    if(W_VCNT_RET)     R_V_DISPTMG <= 1'b1; 
    else if(W_VDISP_N) R_V_DISPTMG <= 1'b0; 
    if(W_HD)           R_DISPTMG <= R_V_DISPTMG; 
    else if(W_HDISP_N) R_DISPTMG <= 1'b0; 
  end 
end 
endmodule