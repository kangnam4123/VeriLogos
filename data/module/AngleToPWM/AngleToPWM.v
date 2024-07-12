module AngleToPWM(
	input wire [RC_SIGNAL_WIDTH-1:0] pos,
	input wire clk1MHz,
	input wire rst,
	output reg pwm
);
parameter RC_SIGNAL_WIDTH = 11;
parameter PIN_POS_WIDTH = 10;
parameter BCD_WIDTH = 4;
parameter POSITION_FILE_WIDTH = 32;
parameter POSITION_WIDTH = 11;
parameter PWMS = 4;
parameter time_width   = 20000; 
parameter pos_time_min = 500; 
parameter pos_time_max = 2500; 
integer current_time;
reg [10:0] stored_pos;
reg [1:0] state;
always @(posedge clk1MHz or posedge rst) begin
	if (rst) begin
		pwm = 1'b1;
		state = 3'b0;
		current_time = 0;
		stored_pos = 0;
	end
	else if(pos > 2500 || pos < 0) begin
		pwm = 1'b1;
	end
	else begin
		case(state)
			0: begin 
				pwm = 1;
				stored_pos = pos;
				state = 3'h1;
			end
			1: begin
				pwm = 1;
				if (current_time >= stored_pos) begin
					state = 3'h2;
				end
			end
			2: begin
				pwm = 0;
				if (current_time >= time_width) begin
					state = 3'h0;
					current_time = 0;
				end
			end
		endcase
		current_time = current_time + 1;
	end
end
endmodule