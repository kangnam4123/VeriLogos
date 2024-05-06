module fpu_cnt_lead0_lvl4 (
	din_31_16_eq_0,
	din_31_24_eq_0,
	lead0_16b_2_hi,
	lead0_16b_1_hi,
	lead0_16b_0_hi,
	din_15_0_eq_0,
	din_15_8_eq_0,
	lead0_16b_2_lo,
	lead0_16b_1_lo,
	lead0_16b_0_lo,
	din_31_0_eq_0,
	lead0_32b_3,
	lead0_32b_2,
	lead0_32b_1,
	lead0_32b_0
);
input		din_31_16_eq_0;		
input		din_31_24_eq_0;		
input		lead0_16b_2_hi;		
input		lead0_16b_1_hi;		
input		lead0_16b_0_hi;		
input		din_15_0_eq_0;		
input		din_15_8_eq_0;		
input		lead0_16b_2_lo;		
input		lead0_16b_1_lo;		
input		lead0_16b_0_lo;		
output		din_31_0_eq_0;		
output		lead0_32b_3;		
output		lead0_32b_2;		
output		lead0_32b_1;		
output		lead0_32b_0;		
wire		din_31_0_eq_0;
wire		lead0_32b_3;
wire		lead0_32b_2;
wire		lead0_32b_1;
wire		lead0_32b_0;
assign din_31_0_eq_0= din_15_0_eq_0 && din_31_16_eq_0;
assign lead0_32b_3= ((!din_31_16_eq_0) && din_31_24_eq_0)
		|| (din_31_16_eq_0 && din_15_8_eq_0);
assign lead0_32b_2= ((!din_31_16_eq_0) && lead0_16b_2_hi)
		|| (din_31_16_eq_0 && lead0_16b_2_lo);
assign lead0_32b_1= ((!din_31_16_eq_0) && lead0_16b_1_hi)
		|| (din_31_16_eq_0 && lead0_16b_1_lo);
assign lead0_32b_0= ((!din_31_16_eq_0) && lead0_16b_0_hi)
		|| (din_31_16_eq_0 && lead0_16b_0_lo);
endmodule