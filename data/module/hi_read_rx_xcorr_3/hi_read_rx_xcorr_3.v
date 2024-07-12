module hi_read_rx_xcorr_3(
    pck0, ck_1356meg, ck_1356megb,
    pwr_lo, pwr_hi, pwr_oe1, pwr_oe2, pwr_oe3, pwr_oe4,
    adc_d, adc_clk,
    ssp_frame, ssp_din, ssp_dout, ssp_clk,
    cross_hi, cross_lo,
    dbg,
    xcorr_is_848, snoop
);
    input pck0, ck_1356meg, ck_1356megb;
    output pwr_lo, pwr_hi, pwr_oe1, pwr_oe2, pwr_oe3, pwr_oe4;
    input [7:0] adc_d;
    output adc_clk;
    input ssp_dout;
    output ssp_frame, ssp_din, ssp_clk;
    input cross_hi, cross_lo;
    output dbg;
    input xcorr_is_848, snoop;
assign pwr_hi = ck_1356megb & (~snoop);
assign pwr_oe1 = 1'b0;
assign pwr_oe3 = 1'b0;
assign pwr_oe4 = 1'b0;
wire adc_clk = ck_1356megb;
reg fc_div_2;
always @(negedge ck_1356megb)
    fc_div_2 <= fc_div_2 + 1;
reg after_hysteresis, after_hysteresis_prev, after_hysteresis_prev_prev;
reg [11:0] has_been_low_for;
always @(negedge adc_clk)
begin
    if(& adc_d[7:0]) after_hysteresis <= 1'b1;
    else if(~(| adc_d[7:0])) after_hysteresis <= 1'b0;
    if(after_hysteresis)
    begin
        has_been_low_for <= 7'b0;
    end
    else
    begin
        if(has_been_low_for == 12'd4095)
        begin
            has_been_low_for <= 12'd0;
            after_hysteresis <= 1'b1;
        end
        else
            has_been_low_for <= has_been_low_for + 1;
    end
end
reg [5:0] corr_i_cnt;
reg signed [13:0] corr_i_accum;
reg signed [13:0] corr_q_accum;
reg signed [7:0] corr_i_out;
reg signed [7:0] corr_q_out;
reg ssp_clk;
reg ssp_frame;
always @(negedge adc_clk)
begin
	if (xcorr_is_848 | fc_div_2)
		corr_i_cnt <= corr_i_cnt + 1;
end		
always @(negedge adc_clk)
begin
    if(corr_i_cnt == 6'd0)
    begin
        if(snoop)
        begin
            corr_i_out <= {corr_i_accum[13:7], after_hysteresis_prev_prev};
            corr_q_out <= {corr_q_accum[13:7], after_hysteresis_prev};
			after_hysteresis_prev_prev <= after_hysteresis;
        end
        else
        begin
            corr_i_out <= corr_i_accum[13:6];
            corr_q_out <= corr_q_accum[13:6];
        end
        corr_i_accum <= adc_d;
        corr_q_accum <= adc_d;
    end
    else
    begin
        if(corr_i_cnt[3])
            corr_i_accum <= corr_i_accum - adc_d;
        else
            corr_i_accum <= corr_i_accum + adc_d;
        if(corr_i_cnt[3] == corr_i_cnt[2])			
            corr_q_accum <= corr_q_accum + adc_d;
        else
            corr_q_accum <= corr_q_accum - adc_d;
    end
    if(corr_i_cnt == 6'd32)
        after_hysteresis_prev <= after_hysteresis;
    if(corr_i_cnt[1:0] == 2'b10)
        ssp_clk <= 1'b0;
    if(corr_i_cnt[1:0] == 2'b00)
    begin
        ssp_clk <= 1'b1;
        if(corr_i_cnt != 7'd0)
        begin
            corr_i_out[7:0] <= {corr_i_out[6:0], corr_q_out[7]};
            corr_q_out[7:1] <= corr_q_out[6:0];
        end
    end
    if(corr_i_cnt[5:2] == 4'b0000 || corr_i_cnt[5:2] == 4'b1000)
        ssp_frame = 1'b1;
    else
        ssp_frame = 1'b0;
end
assign ssp_din = corr_i_out[7];
assign dbg = corr_i_cnt[3];
assign pwr_lo = 1'b0;
assign pwr_oe2 = 1'b0;
endmodule