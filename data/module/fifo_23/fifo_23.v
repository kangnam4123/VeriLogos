module fifo_23 #(
	parameter log2_addr = 3, data_width = 8
	) ( 
	input n_reset_i,
	input wclk_i,
	input [data_width-1:0] data_i,
	input wr_i,
	input rclk_i,
	output [data_width-1:0] data_o,
	input rd_i,
	output fifo_empty_o,
	output fifo_full_o
	);
	wire [log2_addr-1:0] gray_head; 
	wire [log2_addr-1:0] gray_tail; 
	wire fifo_full;
	wire fifo_empty;
	wire rd_rise, rd_fall, wr_rise, wr_fall;
	reg [data_width-1:0] out = 0;						
	reg [data_width-1:0] fifo_buffer [0:2**log2_addr-1] ;
	reg [log2_addr:0] 	fifo_head = 0;				
	reg [log2_addr:0] 	fifo_tail = 0;				
	reg 						rd = 0, wr = 0;			
	assign gray_head = fifo_head[log2_addr-1:0] ^ {1'b0, fifo_head[log2_addr-1:1]};
	assign gray_tail = fifo_tail[log2_addr-1:0] ^ {1'b0, fifo_tail[log2_addr-1:1]};
	assign data_o = out; 
	assign fifo_full = (gray_head == gray_tail) & (fifo_head[log2_addr] != fifo_tail[log2_addr]);
	assign fifo_empty = (gray_head == gray_tail) & (fifo_head[log2_addr] == fifo_tail[log2_addr]);
	assign fifo_empty_o = fifo_empty;
	assign fifo_full_o = fifo_full;
	always @(posedge wclk_i) wr <= wr_i;
	always @(posedge rclk_i) rd <= rd_i;
	always @(negedge wclk_i)
	begin
		if( n_reset_i == 0 ) fifo_head <= 0;	
		else 
		if( !fifo_full && wr ) fifo_head = fifo_head + 1'b1;
	end
	always @(posedge wclk_i)
		if( !fifo_full && wr_i ) fifo_buffer[fifo_head] = data_i;	
	always @(negedge rclk_i)
	begin
		if( n_reset_i == 0 ) fifo_tail <= 0;
		else 
		if( !fifo_empty && rd ) fifo_tail <= fifo_tail + 1'b1;
	end
	always @(posedge rclk_i)
		if( rd_i ) out <= fifo_buffer[fifo_tail];
endmodule