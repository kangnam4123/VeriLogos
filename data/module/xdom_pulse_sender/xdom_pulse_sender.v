module xdom_pulse_sender (
input		grst_i,
input		odom_clk_i,
input		odom_pulse_i,
input		xdom_clk_i,
output		xdom_pulse_o,
output		busy_o,
output		err_o
);
reg		odom_pulse_delay_r;
reg		odom_pulse_keeper_r;
reg	[1:0]	odom_feedback_double_flips_r	;
reg		err_r;
reg		odom_pulse_gen_r;
wire		xdom_pulse_en;
wire		odom_pulse_safe_cancel;
reg	[1:0]	xdom_double_flips_r		;
reg		xdom_pulse_en_delay_r		;
reg		xdom_pulse_gen_r		;
always @(posedge odom_clk_i or posedge grst_i)
	if (grst_i)
		odom_pulse_delay_r <= 1'b0;
	else
		odom_pulse_delay_r <= odom_pulse_i;
always @(posedge odom_clk_i or posedge grst_i)
	if (grst_i)
		odom_pulse_gen_r <= 1'b0;
	else if ((odom_pulse_i == 1'b1) && (odom_pulse_delay_r == 1'b0))
		odom_pulse_gen_r <= 1'b1;
	else
		odom_pulse_gen_r <= 1'b0;
always @(posedge odom_clk_i or posedge grst_i)
	if (grst_i)
		odom_pulse_keeper_r <= 1'b0;
	else if (odom_pulse_keeper_r == 1'b0 && (odom_pulse_gen_r == 1'b1))
		odom_pulse_keeper_r <= 1'b1;
	else if (odom_pulse_keeper_r == 1'b1 && odom_pulse_safe_cancel == 1'b1)
		odom_pulse_keeper_r <= 1'b0;
	else
		odom_pulse_keeper_r <= odom_pulse_keeper_r;
assign busy_o = odom_pulse_keeper_r | odom_pulse_i | odom_pulse_safe_cancel;
always @(posedge odom_clk_i or posedge grst_i)
	if (grst_i)
		err_r <= 1'b0;
	else 
		err_r <= (odom_pulse_keeper_r == 1'b1) && (odom_pulse_i == 1'b1);
assign err_o = err_r;
always @(posedge xdom_clk_i or posedge grst_i)
	if (grst_i)
		xdom_double_flips_r <= 2'b0;
	else
		xdom_double_flips_r <= {odom_pulse_keeper_r, xdom_double_flips_r[1]};
assign xdom_pulse_en = xdom_double_flips_r[0];
always @(posedge odom_clk_i or posedge grst_i)
	if (grst_i)
		odom_feedback_double_flips_r <= 2'b0;
	else
		odom_feedback_double_flips_r <= {xdom_pulse_en, odom_feedback_double_flips_r[1]};
assign odom_pulse_safe_cancel = odom_feedback_double_flips_r[0];
always @(posedge xdom_clk_i or posedge grst_i)
	if (grst_i)
		xdom_pulse_en_delay_r <= 1'b0;
	else
		xdom_pulse_en_delay_r <= xdom_pulse_en;
always @(posedge xdom_clk_i or posedge grst_i)
	if (grst_i)
		xdom_pulse_gen_r <= 1'b0;
	else if (xdom_pulse_en == 1'b1 && xdom_pulse_en_delay_r == 1'b0)
		xdom_pulse_gen_r <= 1'b1;
	else
		xdom_pulse_gen_r <= 1'b0;
assign xdom_pulse_o = xdom_pulse_gen_r;
endmodule