module filter_sync
#(parameter
	INVALUE  = 32'h1,
	OUTVALUE = 32'h1
)
(
	input       clk       ,
	input       rstn      ,
	input       is_data_in,
	input       is_data_out,
	input       rc_reqn,
	output reg  rc_ackn
);
	reg [1:0] state_c, state_n;
	wire rc_is_idle;
	wire [31:0] rc_tc;
	reg [31:0] rc_tc_0;
	wire [31:0] rc_tc_1;
	assign rc_tc_1 = rc_tc_0 + INVALUE;
	always @(posedge clk or negedge rstn) begin
		if (~rstn) begin
			rc_tc_0 <= 32'h0;
		end else begin
			if (is_data_in) rc_tc_0 <= rc_tc_0 + INVALUE;
			if (is_data_out) rc_tc_0 <= rc_tc_0 - OUTVALUE;
		end
	end
	assign rc_tc = (is_data_in) ? rc_tc_1: rc_tc_0;
	assign rc_is_idle = (rc_tc == 32'h0);
	localparam [1:0]
		RC_Idle    = 4'd0,
		RC_ReqAck  = 4'd1;
	always @(posedge clk or negedge rstn) begin
		if (~rstn)
			state_c <= RC_Idle;
		else
			state_c <= state_n;
	end
	always @(*) begin
		{rc_ackn} = {1'b1};
		case (state_c)
			RC_Idle: begin state_n = (~rc_reqn)? RC_ReqAck:RC_Idle; end
			RC_ReqAck:begin
				if(rc_is_idle) begin
					state_n = RC_Idle;
					rc_ackn = 1'b0;
				end else begin
					state_n = RC_ReqAck;
				end
			end
			default: begin state_n = RC_Idle; end
		endcase
	end
endmodule