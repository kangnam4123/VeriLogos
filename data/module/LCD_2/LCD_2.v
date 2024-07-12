module LCD_2 (
	input clk,
	input [7:0] data_in,
	output reg [7:0] data_out,
	output reg lcd_e,
	output reg lcd_r,
	output LED0,
	output LED1,
	output LED2,
	output LED3
); 
assign LED0 = state[0];
assign LED1 = state[1];
assign LED2 = state[2];
assign LED3 = state[3];
localparam INIT   = 4'b0001;
localparam FIRST  = 4'b0010;
localparam SECOND = 4'b0100;
reg [3:0] state = INIT; 
integer j = 0 ; 
integer i = 0 ; 
reg [7:0] conf [0:5];
	initial
		begin 
			conf[0] <= 8'h38; 
			conf[1] <= 8'h0C; 
			conf[2] <= 8'h06; 
			conf[3] <= 8'h01; 
			conf[4] <= 8'h80; 
			conf[5] <= 8'hC0; 
		end 
always @ (posedge clk)
	begin 
		state		<= state;
		data_out	<= data_out;
		case (state)
			INIT: 
				begin
					lcd_r <= 0;
					if (j < 5)
						begin 
						if (i <= 1000000)
							begin 
								lcd_e = 1; 
								data_out <= conf[j];
								i <= i + 1; 
								state <= INIT;
							end 
						else if (i > 1000000 && i < 2000000)
							begin 
								lcd_e = 0;
								i <= i + 1;
								state <= INIT;
							end 
						else if (i == 2000000)
							begin 
								j <= j + 1;
								i <= 0; 
								state <= INIT;
							end 
						end 
					else 
						begin
							j <= 0;
							lcd_r <= 1; 
							state <= FIRST;
						end 
				end 
			FIRST:
				begin 
					if (j < 16)
						begin
							if (i <= 1000000)
								begin
									lcd_e <= 1;
									data_out <= data_in;
									i <= i + 1;
									state <= FIRST; 
								end 
							else if (i > 1000000 && i < 2000000)
								begin 
									lcd_e = 0;
									i <= i + 1;
									state <= FIRST;
								end 
							else if (i == 2000000)
								begin 
									j <= j + 1;
									i <= 0; 
									state <= FIRST;
								end 
						end 
					else
						begin 
							j <= 0;
							lcd_r <= 0;
							data_out <= conf[5];
							state <= SECOND;
						end 
				end 
			SECOND:
				begin 
					lcd_r <= 1;
					if (j < 16)
						begin
							if (i <= 1000000)
								begin
									lcd_e <= 1;
									data_out <= data_in;
									i <= i + 1;
									state <= SECOND; 
								end 
							else if (i > 1000000 && i < 2000000)
								begin 
									lcd_e = 0;
									i <= i + 1;
									state <= SECOND;
								end 
							else if (i == 2000000)
								begin 
									j <= j + 1;
									i <= 0; 
									state <= SECOND;
								end 
						end 
					else
						begin 
							j <= 0;
							lcd_r <= 0;
							data_out <= conf[5];
							state <= INIT;
						end 
				end 
				default: state <= INIT;
		endcase 
	end 
	endmodule