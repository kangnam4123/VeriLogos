module rs232_send #(
	parameter integer PERIOD = 10
) (
	input  clk,
	output TX,
	input  LED1,
	input  LED2,
	input  LED3,
	input  LED4,
	input  LED5
);
	reg [7:0] buffer;
	reg buffer_valid;
	reg [$clog2(PERIOD):0] cycle_cnt = 0;
	reg [4:0] bit_cnt = 0;
	reg [5:0] byte_cnt = 60;
	always @(posedge clk) begin
		cycle_cnt <= cycle_cnt + 1;
		if (cycle_cnt == PERIOD-1) begin
			cycle_cnt <= 0;
			bit_cnt <= bit_cnt + 1;
			if (bit_cnt == 10) begin
				bit_cnt <= 0;
				byte_cnt <= byte_cnt + 1;
			end
		end
	end
	reg [7:0] data_byte;
	reg data_bit;
	always @* begin
		data_byte = 'bx;
		case (byte_cnt)
			0: data_byte <= "\r";
			1: data_byte <= LED1 ? "*" : "-";
			2: data_byte <= LED2 ? "*" : "-";
			3: data_byte <= LED3 ? "*" : "-";
			4: data_byte <= LED4 ? "*" : "-";
			5: data_byte <= LED5 ? "*" : "-";
		endcase
	end
	always @(posedge clk) begin
		data_bit = 'bx;
		case (bit_cnt)
			0: data_bit <= 0; 
			1: data_bit <= data_byte[0];
			2: data_bit <= data_byte[1];
			3: data_bit <= data_byte[2];
			4: data_bit <= data_byte[3];
			5: data_bit <= data_byte[4];
			6: data_bit <= data_byte[5];
			7: data_bit <= data_byte[6];
			8: data_bit <= data_byte[7];
			9: data_bit <= 1;  
			10: data_bit <= 1; 
		endcase
		if (byte_cnt > 5) begin
			data_bit <= 1;
		end
	end
	assign TX = data_bit;
endmodule