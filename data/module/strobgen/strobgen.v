module strobgen(
	input clk_sys,
	input ss11, ss12, ss13, ss14, ss15,
	input ok$, zw, oken,
	input mode, step,
	input strob_fp,
	input strobb_fp,
	output ldstate,
	output got,
	output strob1,
	output strob1b,
	output strob2,
	output strob2b
);
	localparam S_GOT	= 3'd0;
	localparam S_GOTW	= 3'd1;
	localparam S_ST1	= 3'd2;
	localparam S_ST1W	= 3'd3;
	localparam S_ST1B	= 3'd4;
	localparam S_PGOT	= 3'd5;
	localparam S_ST2	= 3'd6;
	localparam S_ST2B	= 3'd7;
	wire if_busy = zw & oken;
	wire es1 = ss11 | (ss12 & ok$) | (ss13 & ok$) | ss14 | ss15;
	wire has_strob2 = ss11 | ss12;
	wire no_strob2 = ss13 | ss14 | ss15;
	assign got = state == S_GOT;
	assign strob1 = (state == S_ST1) | strob_fp;
	assign strob1b = (state == S_ST1B) | strobb_fp;
	assign strob2 = state == S_ST2;
	assign strob2b = state == S_ST2B;
	assign ldstate = ~if_busy & ((state == S_PGOT) | ((state == S_ST1B) & no_strob2) | (state == S_ST2B));
	reg lstep;
	always @ (posedge clk_sys) begin
		lstep <= step;
	end
	wire step_trig = ~mode | (step & ~lstep);
	reg [0:2] state;
	always @ (posedge clk_sys) begin
		case (state)
			S_GOT: begin
				if (es1) begin
					state <= S_ST1;
				end else begin
					state <= S_GOTW;
				end
			end
			S_GOTW: begin
				if (es1) begin
					state <= S_ST1;
				end
			end
			S_ST1: begin
				if (step_trig) state <= S_ST1B;
				else state <= S_ST1W;
			end
			S_ST1W: begin
				if (step_trig) state <= S_ST1B;
			end
			S_ST1B: begin
				if (has_strob2) begin
					state <= S_ST2;
				end else if (no_strob2 & ~if_busy) begin
					state <= S_GOT;
				end else begin
					state <= S_PGOT;
				end
			end
			S_ST2: begin
				state <= S_ST2B;
			end
			S_ST2B: begin
				if (~if_busy) begin
					state <= S_GOT;
				end else begin
					state <= S_PGOT;
				end
			end
			S_PGOT: begin
				if (~if_busy) begin
					state <= S_GOT;
				end
			end
		endcase
	end
endmodule