module uart_3(clk, TxD, TxD_data, TxD_start, TxD_busy, RxD, RxD_data, RxD_ready, RxD_read);
	input clk;
	input [7:0] TxD_data;
	input TxD_start;
	output TxD;
	output TxD_busy;
	input RxD;
	output [7:0] RxD_data;
	output RxD_ready;
	input RxD_read;
parameter Counter = 1302;
localparam Counter8 = Counter >> 3;	
reg [7:0] chr = 8'h48;
reg [7:0] state = 0;
reg [12:0] count = 0;
always @(posedge clk)
	if(count == 0)
		case (state)
			8'b00000000:	if(TxD_start) { chr, state, count } <= { TxD_data, 8'b11000000, 13'd1 }; else { state, count } <= { 8'd0, 13'd0 };
			8'b11000000:	{ state, count } <= { 8'b10100000, 13'd1 };
			8'b10100000:	{ state, count } <= { 8'b10100001, 13'd1 };
			8'b10100001:	{ state, count } <= { 8'b10100010, 13'd1 };
			8'b10100010:	{ state, count } <= { 8'b10100011, 13'd1 };
			8'b10100011:	{ state, count } <= { 8'b10100100, 13'd1 };
			8'b10100100:	{ state, count } <= { 8'b10100101, 13'd1 };
			8'b10100101:	{ state, count } <= { 8'b10100110, 13'd1 };
			8'b10100110:	{ state, count } <= { 8'b10100111, 13'd1 };
			8'b10100111:	{ state, count } <= { 8'b10010000, 13'd1 };
			8'b10010000:	{ state, count } <= { 8'b10010001, 13'd1 };
			default:			{ state, count } <= { 8'b00000000, 13'd0 };
		endcase
	else
		if(count == Counter)
			count <= 13'd0;
		else
			count <= count + 13'd1;
assign TxD = (state[6:5] == 0) | (state[5] & chr[state[2:0]]);
assign TxD_busy = state != 0;
reg [7:0] RxD_data = 8'd0;
reg [3:0] RxD_state = 4'd0;
reg [3:0] RxD_filter = 4'd0;
reg RxD_filtered = 1'b0;
reg [2:0] RxD_filter_idx = 3'd0;
reg [12:0] RxD_count = 13'd0;
reg stop_bit = 1'b0;
always @(posedge clk)
	case(RxD_filter)
		4'b0000, 4'b0001, 4'b0010, 4'b0100, 4'b1000:	RxD_filtered <= 1'b0;
		default:	RxD_filtered <= 1'b1;
	endcase
always @(posedge clk)
	if(~|RxD_state) begin	
		if(RxD_read)
			stop_bit = 1'b0;		
		if(~RxD)
			{ RxD_state, RxD_count } = { 4'd1, 13'd0 };		
		else
			{ RxD_state, RxD_count } = { 4'd0, 13'd0 };
	end
	else
		if(RxD_count == Counter8) begin
			{ RxD_count, RxD_filter_idx } = { 13'd0, RxD_filter_idx + 3'd1 };
			if(RxD_filter_idx == 3'd0)		
				case(RxD_state)
					4'd1:		
						if(RxD_filtered)
							RxD_state = 4'd0;	
						else
							RxD_state = 4'd2;
					4'd2:	{ RxD_data[0], RxD_state } = { RxD_filtered, 4'd3 };
					4'd3:	{ RxD_data[1], RxD_state } = { RxD_filtered, 4'd4 };
					4'd4:	{ RxD_data[2], RxD_state } = { RxD_filtered, 4'd5 };
					4'd5:	{ RxD_data[3], RxD_state } = { RxD_filtered, 4'd6 };
					4'd6:	{ RxD_data[4], RxD_state } = { RxD_filtered, 4'd7 };
					4'd7:	{ RxD_data[5], RxD_state } = { RxD_filtered, 4'd8 };
					4'd8:	{ RxD_data[6], RxD_state } = { RxD_filtered, 4'd9 };
					4'd9:	{ RxD_data[7], RxD_state } = { RxD_filtered, 4'd10 };
					4'd10: { stop_bit, RxD_state } = { RxD_filtered, 4'd0 };
					default: { stop_bit, RxD_state } = { 1'b0, 4'd0 };
				endcase
			else if(RxD_filter_idx == 3'd2) RxD_filter[0] = RxD;
			else if(RxD_filter_idx == 3'd3) RxD_filter[1] = RxD;
			else if(RxD_filter_idx == 3'd4) RxD_filter[2] = RxD;
			else if(RxD_filter_idx == 3'd5) RxD_filter[3] = RxD;
		end
		else
			RxD_count = RxD_count + 13'd1;
assign RxD_ready = (~|RxD_state & stop_bit);		
endmodule