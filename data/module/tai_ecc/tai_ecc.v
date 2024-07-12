module tai_ecc(
	input				clk,
	input				rst_n,
	input				pps,
	input	[63 : 0]	tai_sec_1,
	input	[63 : 0]	tai_sec_2,
	input	[63 : 0]	tai_sec_3,
	output	[63 : 0]	tai_sec_correct,
	output	[ 7 : 0]	tai_cnt_err_1,
	output	[ 7 : 0]	tai_cnt_err_2,
	output	[ 7 : 0]	tai_cnt_err_3,
	output	reg			fault_interrupt
);
localparam	IDLE			= 5'b0;
localparam	WAIT_PPS_RISE	= 5'b1;
localparam	GET_DATA		= 5'b10;
localparam	CMP_DATA		= 5'b100;
localparam	ERROR_CNT		= 5'b1000;
localparam	WAIT_PPS_FALL	= 5'b10000;
reg			[ 4 : 0]	corr_state;
reg			[ 4	: 0]	corr_next_state;
reg			[63	: 0]	tai_sec_1_hold;
reg			[63	: 0]	tai_sec_2_hold;
reg			[63	: 0]	tai_sec_3_hold;
reg			[63	: 0]	tai_most_probably_fine;
reg			[63	: 0]	last_sec;
reg			[ 7	: 0]	t1_err;
reg			[ 7 : 0]	t2_err;
reg			[ 7	: 0]	t3_err;
reg						t1_equal_t2;
reg						t1_equal_t3;
reg						t2_equal_t3;
assign tai_sec_correct = tai_most_probably_fine;
assign tai_cnt_err_1 = t1_err;
assign tai_cnt_err_2 = t2_err;
assign tai_cnt_err_3 = t3_err;
always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n) begin
		tai_most_probably_fine <= 64'b0;
	end
	else begin
		tai_most_probably_fine <= ((tai_sec_1	&	tai_sec_2	&	tai_sec_3) |
								(( ~tai_sec_1)	&	tai_sec_2	&	tai_sec_3) |
								(	tai_sec_1	& (~tai_sec_2)	&	tai_sec_3) |
								(	tai_sec_1	&	tai_sec_2	& (~tai_sec_3)));
	end
end
always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n) begin
		corr_state <= 0;
	end
	else begin
		corr_state <= corr_next_state;
	end
end
always @ (*)
begin
	case (corr_state)
		IDLE			: begin
			corr_next_state = WAIT_PPS_RISE;
		end
		WAIT_PPS_RISE	: begin
			if (pps) begin
				corr_next_state = GET_DATA;
			end
			else begin
				corr_next_state = WAIT_PPS_RISE;
			end
		end
		GET_DATA		: begin
			corr_next_state = CMP_DATA;
		end
		CMP_DATA		: begin
			corr_next_state	= ERROR_CNT;
		end
		ERROR_CNT		: begin
			corr_next_state = WAIT_PPS_FALL;
		end
		WAIT_PPS_FALL	: begin
			if (!pps) begin
				corr_next_state = WAIT_PPS_RISE;
			end
			else begin
				corr_next_state = WAIT_PPS_FALL;
			end
		end
		default			: begin
			corr_next_state = IDLE;
		end
	endcase
end
always @ (posedge clk or negedge rst_n)
begin
	if (!rst_n) begin
		tai_sec_1_hold <= 64'b0;
		tai_sec_2_hold <= 64'b0;
		tai_sec_3_hold <= 64'b0;
		t1_equal_t2 <= 1'b0;
		t1_equal_t3 <= 1'b0;
		t2_equal_t3 <= 1'b0;
		fault_interrupt <= 1'b0;
		t1_err <= 8'b0;
		t2_err <= 8'b0;
		t3_err <= 8'b0;
	end
	else begin
		case (corr_state)
		IDLE			: begin
		end
		WAIT_PPS_RISE	: begin
		end
		GET_DATA		: begin
			tai_sec_1_hold <= tai_sec_1;
			tai_sec_2_hold <= tai_sec_2;
			tai_sec_3_hold <= tai_sec_3;
		end
		CMP_DATA		: begin
			t1_equal_t2 <= (tai_sec_1_hold == tai_sec_2_hold) ? 1'b1 : 1'b0;
			t1_equal_t3 <= (tai_sec_1_hold == tai_sec_3_hold) ? 1'b1 : 1'b0;
			t2_equal_t3 <= (tai_sec_2_hold == tai_sec_3_hold) ? 1'b1 : 1'b0;
		end
		ERROR_CNT		: begin
			casez ({t1_equal_t2, t1_equal_t3, t2_equal_t3})
				3'b11?	: begin
					fault_interrupt <= 1'b0;
				end
				3'b10?	: begin
					t3_err <= t3_err + 1'b1;
					fault_interrupt <= 1'b1;
				end
				3'b01?	: begin
					t2_err <= t2_err + 1'b1;
					fault_interrupt <= 1'b1;
				end
				3'b001	: begin
					t1_err <= t1_err + 1'b1;
					fault_interrupt <= 1'b1;
				end
				3'b000	: begin
					fault_interrupt <= 1'b1;
				end
			endcase
		end
		WAIT_PPS_FALL	: begin
		end
		endcase
	end
end
endmodule