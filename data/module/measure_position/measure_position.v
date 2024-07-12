module measure_position #(
	parameter INPUT_WIDTH  = 11,
	parameter COLOR_WIDTH  = 10,
	parameter FRAME_X_MAX  = 640,
	parameter FRAME_Y_MAX  = 480,
	parameter COUNT_THRESH = 40
)(	
	input 		          					clk,
	input wire		[(INPUT_WIDTH-1):0]		vga_x,
	input wire		[(INPUT_WIDTH-1):0]		vga_y,
	input wire 		[(COLOR_WIDTH-1):0]		delta_frame,
	output wire		[(INPUT_WIDTH-1):0]		x_position,
	output wire		[(INPUT_WIDTH-1):0]		y_position,
	output wire								xy_valid,
	input wire								aresetn,
	input wire								enable
);
reg [18:0]				total_count;
reg [26:0] 				x_coordinate_sum;
reg [26:0]		   		y_coordinate_sum;
reg [(INPUT_WIDTH-1):0]	int_x_position;
reg [(INPUT_WIDTH-1):0]	int_y_position;
reg						int_xy_valid;
assign x_position     = int_x_position;
assign y_position 	  = int_y_position;
assign xy_valid       = int_xy_valid;
always @(posedge clk or negedge aresetn) begin
	if (~aresetn) 	
		begin
			total_count 	 <= 'd0;
			x_coordinate_sum <= 'd0;
			y_coordinate_sum <= 'd0;
		end
	else if (~enable) 	
		begin
			total_count 	 <= 'd0;
			x_coordinate_sum <= 'd0;
			y_coordinate_sum <= 'd0;
		end		
	else if (vga_x == FRAME_X_MAX & vga_y == FRAME_Y_MAX)
		begin
			total_count		 <= 'd0;
			x_coordinate_sum <= 'd0;
			y_coordinate_sum <= 'd0;
		end		
	else if (&delta_frame)
		begin
			total_count		 <= total_count + 1;
			x_coordinate_sum <= x_coordinate_sum + vga_x;
			y_coordinate_sum <= y_coordinate_sum + vga_y;
		end
	else 
		begin
			total_count 	 <= total_count;
			x_coordinate_sum <= x_coordinate_sum;
			y_coordinate_sum <= y_coordinate_sum;
		end
end
always @(posedge clk or negedge aresetn) begin
	if (~aresetn)
		begin
			int_xy_valid		<= 1'b0;
			int_x_position      <= 'd0;
			int_y_position      <= 'd0;
		end	
	else if (~enable)
		begin
			int_xy_valid		<= 1'b0;
			int_x_position 	    <= 'd0;
			int_y_position 	    <= 'd0;		
		end
	else if (vga_x == FRAME_X_MAX & vga_y == FRAME_Y_MAX)
		begin
			int_xy_valid		<= 1'b1;
			if (total_count < COUNT_THRESH) 
				begin
					int_x_position 	    <= {INPUT_WIDTH {1'b1}}; 
					int_y_position 	    <= {INPUT_WIDTH {1'b1}};
				end
			else
				begin
					int_x_position 	    <= x_coordinate_sum / total_count; 
					int_y_position 	    <= y_coordinate_sum / total_count;
				end
		end
	else 
		begin
			int_xy_valid		<= 1'b0;
			int_x_position 		<= int_x_position;
			int_y_position 		<= int_y_position;
		end
end
endmodule