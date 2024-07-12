module serial2spi (reset, clk, rx, tx, rts, cts, sck, mosi, miso);
	input reset;
	input clk;
	input  rx;
	output tx;
	input  rts;
	output cts;
	output sck;
	output mosi;
	input  miso;
	reg    tx;
	wire   cts;
	reg    sck;
	reg    mosi;
	reg    [7:0] data;
	reg    [3:0] multi_status;
	reg    [2:0] count;
	reg    receiving_serial;
	reg    communicating_avr;
	reg    sending_serial;
	reg    serial_wait;
	reg    serial_start;
	reg    serial_stop;
	reg    serial_error;
	assign cts = rts & (~receiving_serial | serial_start) & ~communicating_avr & ~sending_serial;
	always @(negedge reset) begin
		multi_status <= 4'b0;
		count <= 3'b0;
		receiving_serial <= 1'b0;
		sending_serial <= 1'b0;
		tx <= 1'b1;
		sck <= 1'b0;
		mosi <= 1'b0;
		data <= 8'b0;
		multi_status <= 4'b0;
		count <= 3'b0;
		receiving_serial <= 1'b0;
		communicating_avr <= 1'b0;
		sending_serial <= 1'b0;
		serial_wait <= 1'b0;
		serial_start <= 1'b0;
		serial_stop <= 1'b0;
		serial_error <= 1'b0;
	end
	always @(posedge clk) begin
		if (reset) begin
			if (receiving_serial) begin
				multi_status <= multi_status + 4'b1;
				if (multi_status == 4'b1111) begin
					if (~serial_wait) begin
						if (serial_error) begin
							if (rx) begin
								serial_error <= 1'b0;
								receiving_serial <= 1'b0;
							end
						end else if (serial_start) begin
							if (rx) receiving_serial <= 1'b0; 
							serial_start <= 1'b0;
						end else if (serial_stop) begin
							if (rx) begin
								count <= 3'b0;
								receiving_serial <= 1'b0;
								communicating_avr <= 1'b1;
								serial_wait <= 1'b1;
								serial_stop <= 1'b0;
							end else begin
								serial_error <= 1'b1;
							end
						end else begin
							data[7:0] <= { rx, data[7:1] };
							count <= count + 3'b1;
							if (count == 3'b111) serial_stop <= 1'b1;
						end
					end
					serial_wait <= ~serial_wait;
				end
			end else if (communicating_avr) begin
				multi_status <= multi_status + 4'b1;
				if (multi_status == 4'b1111) begin
					if (serial_wait) begin
						sck <= 1'b0;
						mosi <= data[7];
						if (serial_stop) begin
							communicating_avr <= 1'b0;
							sending_serial <= 1'b1;
							serial_stop <= 1'b0;
							count <= 3'b0;
							serial_start <= 1'b1;
						end
					end else begin
						count <= count + 3'b1;
						if (count == 3'b111) serial_stop <= 1'b1;
						sck <= 1'b1;
						mosi <= data[7];
						data[7:0] <= { data[6:0], miso };
					end
					serial_wait <= ~serial_wait;
				end
			end else if (sending_serial) begin
				multi_status <= multi_status + 4'b1;
				if (multi_status == 4'b1111) begin
					if (~serial_wait) begin
						if(serial_stop) begin
							if (serial_start) begin
								sending_serial <= 1'b0;
								serial_start <= 1'b0;
							end else begin
								tx <= 1'b1;
								serial_start <= 1'b1;
							end
						end else if (serial_start) begin
							tx <= 1'b0;
							serial_start <= 1'b0;
						end else begin
							tx <= data[0];
							data[7:0]  <= { 1'b0, data[7:1] };
							if (count === 3'b111) begin
								serial_stop <= 1'b1;
							end
							count <= count + 3'b1;
						end
					end
					serial_wait <= ~serial_wait;
				end
			end else begin
				if (~rx) begin
					count <= 3'b0;
					multi_status <= 4'b0;
					serial_wait <= 1'b0;
					serial_start <=1'b1;
					serial_stop <= 1'b0;
					serial_error <= 1'b0;
					receiving_serial <= 1'b1;
				end
			end
		end
	end
endmodule