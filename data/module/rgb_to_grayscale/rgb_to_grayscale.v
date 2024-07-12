module rgb_to_grayscale #(
	parameter rgb_width = 10
)(
	input 		          					clk,
	input wire		    [(rgb_width-1):0]	RED,
	input wire			[(rgb_width-1):0]	GREEN,
	input wire			[(rgb_width-1):0]	BLUE,
	output wire 		[(rgb_width-1):0]	GRAYSCALE,
	input									valid_in,
	input									aresetn,
	output									valid_out
);
localparam frac_width  = 6;
localparam fixed_width = frac_width + rgb_width;
localparam red_coeff   = 13; 
localparam green_coeff = 45; 
localparam blue_coeff  = 4;  
reg [(fixed_width-1):0] int_gray;
reg 	   			  	int_valid_out;
assign GRAYSCALE = int_gray[(fixed_width-1):frac_width];
assign valid_out = int_valid_out;
always @(posedge clk or negedge aresetn) begin
	if (~aresetn) 		int_gray <= 0;
	else if (valid_in)	int_gray <= red_coeff*RED + green_coeff*GREEN + blue_coeff*BLUE;
	else 				int_gray <= int_gray;
end
always @(posedge clk or negedge aresetn) begin
	if (~aresetn) 	int_valid_out <= 0;
	else 			int_valid_out <= valid_in;
end
endmodule