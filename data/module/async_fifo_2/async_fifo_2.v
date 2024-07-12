module async_fifo_2(
	i_push,
	i_pop,
	i_reset,
	i_wclk,
	i_rclk,
	i_wdata,
	o_rdata,
	o_full,
	o_empty
    );
parameter F_WIDTH = 4;
parameter F_SIZE = 1 << F_WIDTH;
parameter F_MAX = 32; 
input i_reset;
input i_rclk;
input i_wclk;
input i_push;
input i_pop;
input [65:0] i_wdata;
output reg [65:0] o_rdata;
output reg o_empty;
output reg o_full;
reg [F_WIDTH-1:0] read_pos;
reg [F_WIDTH-1:0] write_pos;
reg [65:0] memory[F_SIZE -1 : 0];
reg [7:0] total_count; 
reg [7:0] read_counter;
reg [7:0] write_counter;
always @(*) begin
	total_count = write_counter - read_counter;
   o_empty = (total_count == 0);
   o_full = (total_count == F_MAX);
end
always @(posedge i_wclk) begin
	if(i_reset) begin
		write_counter <= 0;
		write_pos <= 0;
	end
	else if(!o_full && i_push) begin
		memory[write_pos] <= i_wdata;
		write_pos <= write_pos + 1'b1;
		write_counter <= write_counter + 1'b1;
	end
end
always @(posedge i_rclk) begin
	if(i_reset) begin
		read_counter <= 0;
		read_pos <= 0;
	end
	else if(!o_empty && i_pop) begin
		o_rdata <= memory[read_pos];
		read_pos <= read_pos + 1'b1;
		read_counter <= read_counter + 1'b1;
	end
end
endmodule