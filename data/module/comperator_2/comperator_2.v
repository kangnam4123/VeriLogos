module comperator_2 #(parameter data_wd = 16,idx_wd = 4,hi = 15,lo = 0)
	(
	output reg	[data_wd-1:0] 	c_dat,
	output reg	[idx_wd-1 :0] 	c_idx,
	output reg					c_dv,
	input wire	[data_wd-1:0]	d0,		d1,
	input wire	[idx_wd-1 :0]	d0_idx,	d1_idx,
	input wire					d0_dv,	d1_dv,
	input wire					great_n_small
	);
	always @(*) begin
		if (d0_dv && d1_dv && great_n_small) begin
			c_dat = (d0[hi:lo] > d1[hi:lo]) ? d0		: d1;
			c_idx = (d0[hi:lo] > d1[hi:lo]) ? d0_idx	: d1_idx;
			c_dv  = 1'b1;
		end
		else if (d0_dv && d1_dv && !great_n_small) begin
			c_dat = (d0[hi:lo] < d1[hi:lo]) ? d0		: d1;
			c_idx = (d0[hi:lo] < d1[hi:lo]) ? d0_idx	: d1_idx;
			c_dv  = 1'b1;
		end
		else if (d0_dv && !d1_dv) begin
			c_dat = d0;
			c_idx = d0_idx;
			c_dv  = 1'b1;
		end
		else if (!d0_dv && d1_dv) begin
			c_dat = d1;
			c_idx = d1_idx;
			c_dv  = 1'b1;
		end
		else begin	
			c_dat = {data_wd{1'b0}};
			c_idx = {idx_wd {1'b0}};
			c_dv  = 1'b0;
		end
	end
endmodule