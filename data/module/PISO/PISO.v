module PISO (Sclk, Clear, Frame, Shifted, Serial_out, p2s_enable, OutReady);
input Sclk, Clear, p2s_enable, Frame;
input [39:0] Shifted;
output reg Serial_out, OutReady;
reg [5:0] bit_count; 
reg out_rdy, frame_flag;
reg [39:0] piso_reg;
	always @(negedge Sclk)
	begin
		if(Clear == 1'b1)
		begin
			bit_count = 6'd40;
			piso_reg = 40'd0;
			out_rdy = 1'b0;
			frame_flag = 1'b0;
			OutReady = 1'b0;
			Serial_out = 1'b0;
		end
		else if (p2s_enable == 1'b1)
		begin
			piso_reg = Shifted;
			out_rdy = 1'b1;
		end
		else if (Frame == 1'b1 && out_rdy == 1'b1 && frame_flag == 1'b0)
		begin
			bit_count = bit_count - 1'b1;
			Serial_out = piso_reg [bit_count];
			frame_flag = 1'b1;
			out_rdy = 1'b0;
			OutReady = 1'b1;
		end
		else if (frame_flag == 1'b1)
		begin
			bit_count = bit_count - 1'b1;
			Serial_out = piso_reg [bit_count];
			OutReady = 1'b1;
			if (bit_count == 6'd0)
				frame_flag = 1'b0;
		end
		else
		begin
			bit_count = 6'd40;
			Serial_out = 1'b0;
			OutReady = 1'b0;
		end
	end
endmodule