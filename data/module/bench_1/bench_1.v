module bench_1(
    input clk,
    output reg trig = 0,
    output reg data_out = 0
    );
parameter MAX_CNT = 21'd1402596; 
parameter RING_CLK_HOLDOFF = 8'd82;
parameter DOUT_OFFSET = 8'd27;
parameter OPWIDTH = 10'd1000;
reg [20:0] mstr_ctr =21'd0;
reg [9:0] opctr = 10'd0;
reg [7:0] main_ctr = 8'd0;
reg mstr_ctr_tc = 0, main_ctr_tc = 0, ring_clk_edge = 0, dout_en_a = 0, dout_en_b = 0, opctr_counting = 0;
wire dout_en;
always @(posedge clk) begin
	dout_en_b <= dout_en_a;
	ring_clk_edge <= (main_ctr==RING_CLK_HOLDOFF) ? 1'b1 : 1'b0;
	mstr_ctr_tc <= (mstr_ctr==MAX_CNT) ? 1'b1 : 1'b0;
	main_ctr_tc <= (main_ctr==8'd163) ? 1'b1 : 1'b0;
	if (ring_clk_edge && mstr_ctr_tc) mstr_ctr <= 21'd0;
	else if (ring_clk_edge) mstr_ctr <= mstr_ctr + 1;
	else mstr_ctr <= mstr_ctr;
	if (main_ctr_tc) main_ctr <= 8'd0;
	else main_ctr <= main_ctr + 8'd1;
	case (mstr_ctr)
		21'd0: begin
			trig <= 1'b1;
			dout_en_a <= dout_en_a;
			end
		21'd10: begin
			trig <= 1'b0;
			dout_en_a <= dout_en_a;
			end
		21'd24: begin
			trig <= trig;
			dout_en_a <= (main_ctr==DOUT_OFFSET) ? 1'b1 : 1'b0;
			end
		21'd25: begin
			trig <= trig;
			dout_en_a <= 1'b0;
		end
		default: begin
			trig <= trig;
			dout_en_a <= dout_en_a;
			end
	endcase
	if (~opctr_counting) begin
		opctr_counting <= dout_en;
		opctr <= 10'd0;
		data_out <= data_out;
		end
	else if (opctr == 10'd0) begin
		opctr_counting <= opctr_counting;
		opctr <= opctr + 10'd1;
		data_out <= 1'b1;
		end
	else if (opctr == OPWIDTH) begin
		opctr_counting <= 1'b0;
		opctr <= opctr + 10'd1;
		data_out <= 1'b0;
		end
	else begin
		opctr_counting <= opctr_counting;
		opctr <= opctr + 10'd1;
		data_out <= data_out;
		end
end
assign dout_en = dout_en_a & ~dout_en_b;
endmodule