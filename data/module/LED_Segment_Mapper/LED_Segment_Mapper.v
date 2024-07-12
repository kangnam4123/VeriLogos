module LED_Segment_Mapper
(
	input LED_ENABLE_1,
	input LED_ENABLE_2,
	input [15:0] LED_DATA_1,
	input [15:0] LED_DATA_2,
	output [6:0] HEX0,
	output [6:0] HEX1,
	output [6:0] HEX2,
	output [6:0] HEX3,
	output [6:0] HEX4,
	output [6:0] HEX5,
	input CLK
);
	reg [15:0] led_out_reg;
	initial
	begin
		led_out_reg = 16'hFFFF;
	end
	always @(posedge CLK)
	begin
		led_out_reg[ 0] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 0]) | (LED_ENABLE_2 & LED_DATA_2[ 0]) );
		led_out_reg[ 1] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 1]) | (LED_ENABLE_2 & LED_DATA_2[ 1]) );
		led_out_reg[ 2] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 2]) | (LED_ENABLE_2 & LED_DATA_2[ 2]) );
		led_out_reg[ 3] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 3]) | (LED_ENABLE_2 & LED_DATA_2[ 3]) );
		led_out_reg[ 4] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 4]) | (LED_ENABLE_2 & LED_DATA_2[ 4]) );
		led_out_reg[ 5] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 5]) | (LED_ENABLE_2 & LED_DATA_2[ 5]) );
		led_out_reg[ 6] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 6]) | (LED_ENABLE_2 & LED_DATA_2[ 6]) );
		led_out_reg[ 7] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 7]) | (LED_ENABLE_2 & LED_DATA_2[ 7]) );
		led_out_reg[ 8] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 8]) | (LED_ENABLE_2 & LED_DATA_2[ 8]) );
		led_out_reg[ 9] <= ~( (LED_ENABLE_1 & LED_DATA_1[ 9]) | (LED_ENABLE_2 & LED_DATA_2[ 9]) );
		led_out_reg[10] <= ~( (LED_ENABLE_1 & LED_DATA_1[10]) | (LED_ENABLE_2 & LED_DATA_2[10]) );
		led_out_reg[11] <= ~( (LED_ENABLE_1 & LED_DATA_1[11]) | (LED_ENABLE_2 & LED_DATA_2[11]) );
		led_out_reg[12] <= ~( (LED_ENABLE_1 & LED_DATA_1[12]) | (LED_ENABLE_2 & LED_DATA_2[12]) );
		led_out_reg[13] <= ~( (LED_ENABLE_1 & LED_DATA_1[13]) | (LED_ENABLE_2 & LED_DATA_2[13]) );
		led_out_reg[14] <= ~( (LED_ENABLE_1 & LED_DATA_1[14]) | (LED_ENABLE_2 & LED_DATA_2[14]) );
		led_out_reg[15] <= ~( (LED_ENABLE_1 & LED_DATA_1[15]) | (LED_ENABLE_2 & LED_DATA_2[15]) );
	end
	assign HEX3[0] = led_out_reg[ 0];
	assign HEX4[0] = led_out_reg[ 1];
	assign HEX5[0] = led_out_reg[ 2];
	assign HEX5[5] = led_out_reg[ 3];
	assign HEX5[4] = led_out_reg[ 4];
	assign HEX5[3] = led_out_reg[ 5];
	assign HEX4[3] = led_out_reg[ 6];
	assign HEX3[3] = led_out_reg[ 7];
	assign HEX2[3] = led_out_reg[ 8];
	assign HEX1[3] = led_out_reg[ 9];
	assign HEX0[3] = led_out_reg[10];
	assign HEX0[2] = led_out_reg[11];
	assign HEX0[1] = led_out_reg[12];
	assign HEX0[0] = led_out_reg[13];
	assign HEX1[0] = led_out_reg[14];	
	assign HEX2[0] = led_out_reg[15];
	assign HEX0[6:4] = ~3'h0;
	assign HEX1[2:1] = ~2'h0;
	assign HEX1[6:4] = ~3'h0;
	assign HEX2[2:1] = ~2'h0;
	assign HEX2[6:4] = ~3'h0;
	assign HEX3[2:1] = ~2'h0;
	assign HEX3[6:4] = ~3'h0;
	assign HEX4[2:1] = ~2'h0;
	assign HEX4[6:4] = ~3'h0;
	assign HEX5[2:1] = ~2'h0;
	assign HEX5[6] = ~1'b0;
endmodule