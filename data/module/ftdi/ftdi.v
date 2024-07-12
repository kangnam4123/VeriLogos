module ftdi
	(
	input clock,
	input [7:0] read_data,
	input read_clock_enable,
	input reset, 
	input fscts, 
	output reg ready, 
	output reg [1:0] state, 
	output reg fsdi);
	reg [9:0] data;
	reg new_data;
	reg [3:0] bit_pos; 
	localparam IDLE = 2'h0, WAIT_CTS = 2'h1, DATA = 2'h2;
	always @(negedge clock or negedge reset) begin
		if (~reset) begin
			ready <= 0;
			new_data <= 0;
		end
		else begin
			if (state == IDLE) begin
				if (~new_data)
					if (~ready)
						ready <= 1;
					else if (read_clock_enable) begin
						data[0] <= 0;
						data[8:1] <= read_data;
						data[9] <= 1;
						new_data <= 1;
						ready <= 0;
					end
			end
			else
				new_data <= 0;
		end
	end
	always @(negedge clock or negedge reset) begin
		if (~reset) begin
			state <= IDLE;
		end
		else begin
			case (state)
				IDLE: begin
					fsdi <= 1;
					if (new_data) begin
						bit_pos <= 0;
						if (fscts)
							state <= DATA;
						else
							state <= WAIT_CTS;
					end
				end
				WAIT_CTS: begin
					if (fscts)
						state <= DATA;
				end
				DATA: begin
					fsdi <= data[bit_pos];
					if (bit_pos == 9)
						state <= IDLE;
					else
						bit_pos <= bit_pos + 1;
				end
				2'h3: begin
					state <= IDLE;
				end
			endcase
		end
	end
endmodule