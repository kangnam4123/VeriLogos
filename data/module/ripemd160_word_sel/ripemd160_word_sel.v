module ripemd160_word_sel (
	input clk,
	input [6:0] rx_round,
	output reg [3:0] tx_s0,
	output reg [3:0] tx_s1
);
	localparam [319:0] first_sequence = {4'd13,4'd15,4'd6,4'd11,4'd8,4'd3,4'd1,4'd14,4'd10,4'd2,4'd12,4'd7,4'd9,4'd5,4'd0,4'd4,4'd2,4'd6,4'd5,4'd14,4'd15,4'd7,4'd3,4'd13,4'd4,4'd12,4'd8,4'd0,4'd10,4'd11,4'd9,4'd1,4'd12,4'd5,4'd11,4'd13,4'd6,4'd0,4'd7,4'd2,4'd1,4'd8,4'd15,4'd9,4'd4,4'd14,4'd10,4'd3,4'd8,4'd11,4'd14,4'd2,4'd5,4'd9,4'd0,4'd12,4'd3,4'd15,4'd6,4'd10,4'd1,4'd13,4'd4,4'd7,4'd15,4'd14,4'd13,4'd12,4'd11,4'd10,4'd9,4'd8,4'd7,4'd6,4'd5,4'd4,4'd3,4'd2,4'd1,4'd0};
	localparam [319:0] second_sequence = {4'd11,4'd9,4'd3,4'd0,4'd14,4'd13,4'd2,4'd6,4'd7,4'd8,4'd5,4'd1,4'd4,4'd10,4'd15,4'd12,4'd14,4'd10,4'd7,4'd9,4'd13,4'd2,4'd12,4'd5,4'd0,4'd15,4'd11,4'd3,4'd1,4'd4,4'd6,4'd8,4'd13,4'd4,4'd0,4'd10,4'd2,4'd12,4'd8,4'd11,4'd9,4'd6,4'd14,4'd7,4'd3,4'd1,4'd5,4'd15,4'd2,4'd1,4'd9,4'd4,4'd12,4'd8,4'd15,4'd14,4'd10,4'd5,4'd13,4'd0,4'd7,4'd3,4'd11,4'd6,4'd12,4'd3,4'd10,4'd1,4'd8,4'd15,4'd6,4'd13,4'd4,4'd11,4'd2,4'd9,4'd0,4'd7,4'd14,4'd5};
	always @ (posedge clk)
	begin
		tx_s0 <= first_sequence >> {rx_round, 2'b00};
		tx_s1 <= second_sequence >> {rx_round, 2'b00};
	end
endmodule