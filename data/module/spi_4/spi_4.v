module spi_4(clk, clk_div, data_in, data_out, send_data, data_ready, spi_sclk, spi_mosi, spi_miso, mode);
	input clk;
	input [31:0] clk_div;
	output [7:0] data_in;
	input [7:0] data_out;
	input send_data;
	output data_ready;
	output spi_sclk;
	output spi_mosi;
	input spi_miso;
	input [1:0] mode;
reg [7:0] xmit_state = 8'hff;		
reg [7:0] next_xmit_state = 8'h00;
reg spi_sclk = 0;
reg [31:0] cd = 32'd0;
reg [7:0] data_in = 8'd0;
reg spi_mosi = 0;
reg latch_buf = 0;
assign data_ready = &xmit_state;
always @(posedge clk)
begin
	begin
		cd = cd + 32'd2;
		if(cd >= clk_div) begin
			if(~&xmit_state) begin
				if(spi_sclk & mode[1])
					xmit_state = xmit_state - 8'h01;
				else if(~spi_sclk & ~mode[1])
					xmit_state = xmit_state - 8'h01;
				next_xmit_state = xmit_state - 8'h1;
				if(&next_xmit_state)
					next_xmit_state = 8'h0;
				spi_sclk = ~spi_sclk;
				if(&xmit_state)
					spi_sclk = mode[1];
				else begin
					if(spi_sclk)
						case(mode)
							2'd0:
								latch_buf = spi_miso;
							2'd1:
								spi_mosi = data_out[xmit_state[2:0]];
							2'd2:
								begin
									spi_mosi = data_out[next_xmit_state[2:0]];
									data_in[xmit_state[2:0]] = latch_buf;
								end
							2'd3:
								data_in[xmit_state[2:0]] = spi_miso;
						endcase
					else
						case(mode)
							2'd0:
								begin
									spi_mosi = data_out[next_xmit_state[2:0]];
									data_in[xmit_state[2:0]] = latch_buf;
								end
							2'd1:
								data_in[xmit_state[2:0]] = spi_miso;
							2'd2:
								latch_buf = spi_miso;
							2'd3:
								spi_mosi = data_out[xmit_state[2:0]];
						endcase
				end
			end
			cd = 32'd0;			
		end			
	end
	if(&xmit_state)
		spi_sclk = mode[1];
	if(send_data & &xmit_state)
	begin
		xmit_state = 8'd8;
		spi_mosi = ~mode[1] & data_out[7];	
	end
end
endmodule