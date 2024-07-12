module read_eeprom(
	input wire clk,
	input wire reset,
	input wire [6:0] slave_addr_w,
	input wire [15:0] mem_addr_w,
	input wire [7:0] read_nbytes_w,
	input wire start,
	output reg [7:0] data_out,
	output reg byte_ready,
	output reg [6:0] i2c_slave_addr,
	output reg i2c_rw,
	output reg [7:0] i2c_write_data,
	output reg [7:0] i2c_nbytes,
	input wire [7:0] i2c_read_data,
	input wire i2c_tx_data_req,
	input wire i2c_rx_data_ready,
	output reg i2c_start,
	output reg busy
	);
	localparam STATE_IDLE = 0;
	localparam STATE_START = 1;
	localparam STATE_WRITE_ADDR = 2;
	localparam STATE_REP_START = 3;
	localparam STATE_READ_DATA = 4;
	localparam READ = 1;
	localparam WRITE = 0;
	reg [3:0] state;
	reg [6:0] slave_addr;
	reg [15:0] mem_addr;
	reg [7:0] read_nbytes; 
	reg waiting_for_tx;
	reg read_prev_data;
	reg [7:0] byte_count;
	always @(posedge clk) begin
		if (reset == 1) begin
			i2c_slave_addr <= 0;
			i2c_rw <= 0;
			i2c_write_data <= 0;
			i2c_start <= 0;
			i2c_nbytes <= 0;
			data_out <= 0;
			byte_ready <= 0;
			mem_addr <= 0;
			slave_addr <= 0;
			read_nbytes <= 0;
			byte_count <= 0;
			waiting_for_tx <= 0;
			busy <= 0;
			state <= STATE_IDLE;
		end else begin
			case(state)
				STATE_IDLE: begin	
					busy <= 0;	
					if (start) begin
						state <= STATE_START;
						slave_addr <= slave_addr_w;
						mem_addr <= mem_addr_w;
						read_nbytes <= read_nbytes_w;
					end
				end 
				STATE_START: begin 
					state <= STATE_WRITE_ADDR;
					i2c_slave_addr <= slave_addr;
					i2c_rw <= WRITE;
					i2c_nbytes <= 2;  
					byte_count <= 2;
					waiting_for_tx <= 0;
					i2c_start <= 1;
					busy <= 1;
				end 
				STATE_WRITE_ADDR: begin
					if (waiting_for_tx == 0) begin
						if (i2c_tx_data_req == 1) begin
							waiting_for_tx <= 1;
							case (byte_count)
								2: begin
									i2c_write_data <= mem_addr[15:8];
									byte_count <= byte_count - 1'b1;
								end 
								1: begin
									i2c_write_data <= mem_addr[7:0];
									byte_count <= byte_count - 1'b1;
									state <= STATE_REP_START;
								end 
							endcase
						end
					end else begin
						if (i2c_tx_data_req == 0) begin
							waiting_for_tx <= 0;
						end 
					end 
				end 
				STATE_REP_START: begin
					state <= STATE_READ_DATA;
					i2c_start <= 1;
					i2c_rw <= READ;
					i2c_nbytes <= read_nbytes;
					read_prev_data <= 0;
					byte_count <= 0;
				end 
				STATE_READ_DATA: begin
					if (read_prev_data == 0) begin
						if (i2c_rx_data_ready) begin
							data_out <= i2c_read_data;
							byte_ready <= 1;
							if (byte_count < (read_nbytes-1)) begin
								byte_count <= byte_count + 1'b1;
								read_prev_data <= 1;
							end else begin
								i2c_start <= 0;
								state <= STATE_IDLE;
							end 
						end 
					end else begin
						if (i2c_rx_data_ready == 0) begin
							read_prev_data <= 0;
							byte_ready <= 0;
						end 
					end 
				end 
			endcase
		end
	end
endmodule