module i2s_shift_out (
	input				clk,				
	input				reset_n,			
	input		[31:0]	fifo_right_data,	
	input		[31:0]	fifo_left_data,		
	input				fifo_ready,			
	output reg			fifo_ack,			
	input				enable,				
	input				bclk,				
	input				lrclk,				
	output				data_out			
);
	reg bclk_delayed;
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			bclk_delayed <= 0;
		end
		else
		begin
			bclk_delayed <= bclk;
		end
	end
	wire bclk_rising_edge = bclk & ~bclk_delayed;
	wire bclk_falling_edge = ~bclk & bclk_delayed;
	reg lrclk_delayed;
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			lrclk_delayed <= 0;
		end
		else
		begin
			lrclk_delayed <= lrclk;
		end
	end
	wire lrclk_rising_edge = lrclk & ~lrclk_delayed;
	wire lrclk_falling_edge = ~lrclk & lrclk_delayed;
	reg [1:0] first_bclk_falling_after_lrclk_rising_r;
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			first_bclk_falling_after_lrclk_rising_r <= 0;
		end
		else
		begin
			if (lrclk_rising_edge)
				first_bclk_falling_after_lrclk_rising_r <= 2'b01;
			else if (first_bclk_falling_after_lrclk_rising_r == 2'b01 && bclk_rising_edge)
				first_bclk_falling_after_lrclk_rising_r <= 2'b10;
			else if (first_bclk_falling_after_lrclk_rising_r == 2'b10 && bclk_falling_edge)
				first_bclk_falling_after_lrclk_rising_r <= 2'b11;
			else if (first_bclk_falling_after_lrclk_rising_r == 2'b11)
				first_bclk_falling_after_lrclk_rising_r <= 2'b00;
		end
	end
	wire first_bclk_falling_after_lrclk_rising = first_bclk_falling_after_lrclk_rising_r == 2'b11;
	reg [1:0] first_bclk_falling_after_lrclk_falling_r;
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			first_bclk_falling_after_lrclk_falling_r <= 0;
		end
		else
		begin
			if (lrclk_falling_edge)
				first_bclk_falling_after_lrclk_falling_r <= 2'b01;
			else if (first_bclk_falling_after_lrclk_falling_r == 2'b01 && bclk_rising_edge)
				first_bclk_falling_after_lrclk_falling_r <= 2'b10;
			else if (first_bclk_falling_after_lrclk_falling_r == 2'b10 && bclk_falling_edge)
				first_bclk_falling_after_lrclk_falling_r <= 2'b11;
			else if (first_bclk_falling_after_lrclk_falling_r == 2'b11)
				first_bclk_falling_after_lrclk_falling_r <= 2'b00;
		end
	end
	wire first_bclk_falling_after_lrclk_falling = first_bclk_falling_after_lrclk_falling_r == 2'b11;
	reg [31:0] shift_register;
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			shift_register <= 0;
		end
		else
		begin
			if (~enable)
				shift_register <= 0;
			else if (first_bclk_falling_after_lrclk_rising)
				shift_register <= fifo_right_data;
			else if (first_bclk_falling_after_lrclk_falling)
				shift_register <= fifo_left_data;
			else if (bclk_falling_edge)
				shift_register <= {shift_register[30:0], 1'b0};
		end
	end
	assign data_out = shift_register[31];
	always @(posedge clk or negedge reset_n)
	begin
		if (~reset_n)
		begin
			fifo_ack <= 0;
		end
		else
		begin
			if (~enable | ~fifo_ready)
				fifo_ack <= 0;
			else
				fifo_ack <= first_bclk_falling_after_lrclk_rising;
		end
	end
endmodule