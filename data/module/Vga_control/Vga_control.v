module Vga_control(
    input [3:0] iRed,
    input [3:0] iGreen,
    input [3:0] iBlue,
    output [9:0] oCurrent_X, 
    output [9:0] oCurrent_Y, 
    output [21:0] oAddress,
    output oRequest,
    output reg oTopOfScreen,     
    output [3:0] oVGA_R,
    output [3:0] oVGA_G,
    output [3:0] oVGA_B,
    output reg oVGA_HS,   
    output reg oVGA_VS,   
    output oVGA_BLANK,    
    output oVGA_CLOCK,    
    input iCLK,
    input iRST_N
);
reg         [10:0]  H_Cont;
reg         [10:0]  V_Cont;
parameter   H_FRONT =   16;
parameter   H_SYNC  =   96;
parameter   H_BACK  =   48;
parameter   H_ACT   =   640;
parameter   H_BLANK =   H_FRONT+H_SYNC+H_BACK;
parameter   H_TOTAL =   H_FRONT+H_SYNC+H_BACK+H_ACT;
parameter   V_FRONT =   10;
parameter   V_SYNC  =   2;
parameter   V_BACK  =   33;
parameter   V_ACT   =   480;
parameter   V_BLANK =   V_FRONT+V_SYNC+V_BACK;
parameter   V_TOTAL =   V_FRONT+V_SYNC+V_BACK+V_ACT;
assign  oVGA_BLANK  =   ~(H_Cont<H_BLANK || V_Cont<V_BLANK);
assign  oVGA_CLOCK  =   ~iCLK;
assign  oVGA_R      =   oRequest ? iRed : 4'b0 ;
assign  oVGA_G      =   oRequest ? iGreen : 4'b0 ;
assign  oVGA_B      =   oRequest ? iBlue : 4'b0 ;
assign  oAddress    =   oCurrent_Y*H_ACT + oCurrent_X;
assign  oRequest    =   H_Cont >= H_BLANK && V_Cont >= V_BLANK;
assign  oCurrent_X  =   (H_Cont>=H_BLANK) ? H_Cont-H_BLANK : 11'h0;
assign  oCurrent_Y  =   (V_Cont>=V_BLANK) ? V_Cont-V_BLANK : 11'h0;
wire oTopOfScreenNext = H_Cont == 0 && V_Cont == 0;
always @(posedge iCLK)
begin
    oTopOfScreen <= oTopOfScreenNext;
end
always@(posedge iCLK or negedge iRST_N)
begin
    if(!iRST_N)
    begin
        H_Cont      <=  0;
        oVGA_HS     <=  1;
    end
    else
    begin
        if(H_Cont<H_TOTAL-1)
            H_Cont  <=  H_Cont+1'b1;
        else
            H_Cont  <=  0;
        if(H_Cont==H_FRONT-1)           
            oVGA_HS <=  1'b0;
        if(H_Cont==H_FRONT+H_SYNC-1)    
            oVGA_HS <=  1'b1;
    end
end
always@(posedge iCLK or negedge iRST_N)
begin
    if(!iRST_N)
    begin
        V_Cont      <=  0;
        oVGA_VS     <=  1;
    end else if (H_Cont == 0) begin
        if(V_Cont<V_TOTAL-1)
            V_Cont  <=  V_Cont+1'b1;
        else
            V_Cont  <=  0;
        if(V_Cont==V_FRONT-1)           
            oVGA_VS <=  1'b0;
        if(V_Cont==V_FRONT+V_SYNC-1)    
            oVGA_VS <=  1'b1;
    end
end
endmodule