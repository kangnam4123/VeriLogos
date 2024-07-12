module i2c_master_1(
		input wire clk,
		input wire reset,
		input wire start,
		input wire [7:0] nbytes_in,
		input wire [6:0] addr_in,
		input wire rw_in,
		input wire [7:0] write_data,
		output reg [7:0] read_data,
		output reg tx_data_req, 
		output reg rx_data_ready, 
		inout wire sda_w,
		output wire scl
	);
	localparam STATE_IDLE = 0;
	localparam STATE_START = 1;
	localparam STATE_ADDR = 2;
	localparam STATE_RW = 3;
	localparam STATE_ACK = 4;
	localparam STATE_READ_ACK = 5;
	localparam STATE_TX_DATA = 6;
	localparam STATE_RX_DATA = 7;
	localparam STATE_STOP = 8;
	localparam READ = 1;
	localparam WRITE = 0;
	localparam ACK = 0;
	reg [5:0] state;
	reg [7:0] bit_count;	
	reg [6:0] addr;
	reg [7:0] data;
	reg [7:0] nbytes;
	reg rw;
	reg scl_en = 0;
	reg sda;
	assign sda_w = ((sda)==0) ? 1'b0 : 1'bz;
	assign scl = (scl_en == 0) ? 1'b1 : ~clk;
	always @(negedge clk) begin
		if (reset == 1) begin
			scl_en <= 0;
		end else begin
			if ((state == STATE_IDLE) || (state == STATE_START) || (state == STATE_STOP)) begin
				scl_en <= 0;
			end
			else begin
				scl_en <= 1;
			end
			if (state == STATE_ACK) begin
				if (0) begin
					state <= STATE_IDLE;
				end
			end
		end
	end
	always @(posedge clk) begin
		if (reset == 1) begin
			state <= STATE_IDLE;
			sda <= 1;
			bit_count <= 8'd0;
			addr <= 0;
			data <= 0;
			nbytes <= 0;
			rw <= 0;
			tx_data_req <= 0;
			rx_data_ready <= 0;
		end	
		else begin
			case(state)
				STATE_IDLE: begin	
					sda <= 1;
					if (start) begin
						state <= STATE_START;
					end 
				end
				STATE_START: begin 
					state <= STATE_ADDR;
					sda <= 0;	
					addr <= addr_in;
					nbytes <= nbytes_in;
					rw <= rw_in;
					if (rw_in == WRITE) begin
						tx_data_req <= 1;  
					end
					bit_count <= 6;	
				end	
				STATE_ADDR: begin 
					sda <= addr[bit_count];
					if (bit_count == 0) begin
						state <= STATE_RW;
					end
					else begin
						bit_count <= bit_count - 1'b1;
					end
				end	
				STATE_RW: begin 
					sda <= rw;
					state <= STATE_ACK;
				end	
				STATE_ACK: begin
					sda <= 1;
					tx_data_req <= 0; 
					if (nbytes == 0) begin
						if (start == 1) begin
							sda <= 1;
							state <= STATE_START;
						end else begin
							sda <= 1; 
							state <= STATE_STOP;
						end	
					end else begin
						if (rw == WRITE) begin
							data <= write_data;  
							bit_count <= 7;  
							state <= STATE_TX_DATA;
						end else begin
							bit_count <= 7;	
							state <= STATE_RX_DATA;
						end 
					end 
				end 
				STATE_TX_DATA: begin
					sda <= data[bit_count];
					if (nbytes > 0) begin
						tx_data_req <= 1;  
					end
					if (bit_count == 0) begin
						state <= STATE_ACK;
						nbytes <= nbytes - 1'b1;
					end
					else begin
						bit_count <= bit_count - 1'b1;
					end
				end	
				STATE_RX_DATA: begin
					data[bit_count] <= sda_w;
					if (bit_count == 0) begin
						state <= STATE_ACK;
						read_data[7:1] <= data[7:1];
						read_data[0] <= sda_w;
						rx_data_ready <= 1;
						nbytes <= nbytes - 1'b1;
					end
					else begin
						bit_count <= bit_count - 1'b1;
						rx_data_ready <= 0;
					end
				end	
				STATE_STOP: begin
					sda <= 1;
					state <= STATE_IDLE;
				end	
			endcase
		end	
	end	
endmodule