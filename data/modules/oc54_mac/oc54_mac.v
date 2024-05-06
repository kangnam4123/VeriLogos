module oc54_mac (
	clk, ena, 
	a, b, t, p, c, d,
	sel_xm, sel_ym, sel_ya,
	bp_a, bp_b, bp_ar, bp_br,
	xm_s, ym_s,
	ovm, frct, smul, add_sub,
	result
	);
input         clk;
input         ena;
input  [15:0] t, p, c, d;               
input  [39:0] a, b;                     
input  [ 1:0] sel_xm, sel_ym, sel_ya;   
input  [39:0] bp_ar, bp_br;             
input         bp_a, bp_b;               
input         xm_s, ym_s;               
input         ovm, frct, smul, add_sub;
output [39:0] result;
reg [39:0] result;
reg  [16:0] xm, ym;              
reg  [39:0] ya;                  
reg  [33:0] mult_res;            
wire [33:0] imult_res;           
reg  [39:0] iresult;             
wire bit1;
assign bit1 = xm_s ? t[15] : 1'b0;
wire bit2;
assign bit2 = ym_s ? p[15] : 1'b0; 
always@(posedge clk)
begin
	if (ena)
		case(sel_xm) 
			2'b00 : xm <= {bit1, t};
			2'b01 : xm <= {bit1, d};
			2'b10 : xm <= bp_a ? bp_ar[32:16] : a[32:16];
			2'b11 : xm <= 17'h0;
		endcase
end
always@(posedge clk)
	if (ena)
		case(sel_ym) 
			2'b00 : ym <= {bit2, p};
			2'b01 : ym <= bp_a ? bp_ar[32:16] : a[32:16];
			2'b10 : ym <= {bit2, d};
			2'b11 : ym <= {bit2, c};
		endcase
always@(posedge clk)
	if (ena)
		case(sel_ya) 
			2'b00 : ya <= bp_a ? bp_ar : a;
			2'b01 : ya <= bp_b ? bp_br : b;
			default : ya <= 40'h0;
		endcase
assign imult_res = (xm * ym); 
always@(xm or ym or smul or ovm or frct or imult_res)
	if (smul && ovm && frct && (xm[15:0] == 16'h8000) && (ym[15:0] == 16'h8000) )
		mult_res = 34'h7ffffff;
	else if (frct)
		mult_res = {imult_res[32:0], 1'b0}; 
	else
		mult_res = imult_res;
always@(mult_res or ya or add_sub)
	if (add_sub)
		iresult = mult_res + ya;
	else
		iresult = mult_res - ya;
always@(posedge clk)
	if (ena)
		result <= iresult;
endmodule