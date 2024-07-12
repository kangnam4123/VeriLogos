module RX
	#( parameter stateA = 'b00001,
		parameter stateB = 'b00010,
		parameter stateC = 'b00100,
		parameter stateD = 'b01000,
		parameter stateE = 'b10000)
	(input clk,
	input baud_rate,
	input rx,
	output reg [7:0] d_out,
	output reg rx_done);
	integer state = stateA;
	integer next_state = stateA;
	reg tick_enable = 0;
	integer count = 0;
	reg rst_count = 1;
	integer bits_count = 0;
	always@(posedge clk)
	begin
		state = next_state;
	end
	always@(posedge clk)
	begin
		case(state)
			stateA:
				if(rx == 1) next_state = stateA;
				else next_state = stateB;
			stateB:
				if(count == 7) next_state = stateC;
				else next_state = stateB;
			stateC:
				next_state = stateD;
			stateD:
				if(bits_count == 8) next_state = stateE;
				else next_state = stateD;
			stateE:
				if(rx_done == 1) next_state = stateA;
				else next_state = stateE;
		endcase
	end
	always@(posedge clk)
	begin
		case(state)
			stateA:
			begin
				rst_count = 1;
				tick_enable = 0;
				rx_done = 0;
			end
			stateB:
			begin
				tick_enable = 1;
			end
			stateC:
			begin
				rst_count = 0;
			end
			stateD:
			begin
				rst_count = 1;
				if(count == 16)
				begin
					d_out = d_out>>1;
					d_out[7] = rx;
					bits_count = bits_count + 1;
					rst_count = 0;
				end
			end
			stateE:
			begin
				if(count == 16 && rx == 1)
				begin
					rx_done = 1;
					bits_count = 0;
					rst_count = 0;
				end
			end
		endcase
	end
	always@(posedge baud_rate or negedge rst_count)
	begin
		if(rst_count == 0) count = 0;
		else
		begin
			if(tick_enable == 1) count = count+1;
		end
	end
endmodule