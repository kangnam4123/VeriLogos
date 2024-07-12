module fpu_denorm_3to1 (
	din2_din1_nz_hi,
	din2_din1_denorm_hi,
	din2_din1_nz_mid,
	din2_din1_denorm_mid,
	din2_din1_nz_lo,
	din2_din1_denorm_lo,
	din2_din1_nz,
	din2_din1_denorm
);
input		din2_din1_nz_hi;	
input		din2_din1_denorm_hi;	
input		din2_din1_nz_mid;	
input		din2_din1_denorm_mid;	
input		din2_din1_nz_lo;	
input		din2_din1_denorm_lo;	
output		din2_din1_nz;		
output		din2_din1_denorm;	
wire		din2_din1_nz;
wire		din2_din1_denorm;
assign din2_din1_nz= din2_din1_nz_hi || din2_din1_nz_mid
		|| din2_din1_nz_lo;
assign din2_din1_denorm= (din2_din1_nz_hi && din2_din1_denorm_hi)
		|| ((!din2_din1_nz_hi) && din2_din1_nz_mid
			&& din2_din1_denorm_mid)
		|| ((!din2_din1_nz_hi) && (!din2_din1_nz_mid)
			&& din2_din1_denorm_lo);
endmodule