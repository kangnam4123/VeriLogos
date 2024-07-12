module SIPO (Frame, Dclk, Clear, InputL, InputR, data_L, data_R, input_rdy_flag);
	input Frame, Dclk, Clear, InputL, InputR;
	output reg input_rdy_flag;
	output reg [15:0] data_L;
	output reg [15:0] data_R;
	reg [3:0] bit_count;
	reg frame_status;
	always @(negedge Dclk or posedge Clear)
	begin
		if (Clear == 1'b1)
		begin
			bit_count = 4'd15;
			data_L = 16'd0;
			data_R = 16'd0;			
			input_rdy_flag = 1'b0;
			frame_status = 1'b0;
		end
		else 
		begin
			if (Frame == 1'b1)
			begin
				bit_count = 4'd15;
				input_rdy_flag = 1'b0;
				data_L [bit_count] = InputL;
				data_R [bit_count] = InputR;
				frame_status = 1'b1;
			end
			else if (frame_status == 1'b1)
			begin
				bit_count = bit_count - 1'b1;
				data_L [bit_count] = InputL;
				data_R [bit_count] = InputR;
				if (bit_count == 4'd0)
				begin
					input_rdy_flag = 1'b1;
					frame_status = 1'b0;
				end
				else
				begin
					input_rdy_flag = 1'b0;
					frame_status = 1'b1;
				end
			end
			else
			begin
				bit_count = 4'd15;
				data_L = 16'd0;
				data_R = 16'd0;			
				input_rdy_flag = 1'b0;
				frame_status = 1'b0;
			end
		end
	end
endmodule