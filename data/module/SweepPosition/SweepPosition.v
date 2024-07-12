module SweepPosition(
	input wire clk200Hz,
	input wire rst,
    input wire [2:0] speed,
    output reg [RC_SIGNAL_WIDTH-1:0] pos
);
parameter RC_SIGNAL_WIDTH = 11;
parameter PIN_POS_WIDTH = 10;
parameter BCD_WIDTH = 4;
parameter POSITION_FILE_WIDTH = 32;
parameter POSITION_WIDTH = 11;
parameter PWMS = 4;
reg dir;
always @(posedge clk200Hz or posedge rst) begin
	if (rst) begin
		pos = 10'd0;
		dir = 0;
	end
	else if(dir == 0) begin
		pos = pos + (speed << 1);
		if(pos >= 2000) begin 
			dir = 1;
		end
	end
	else if(dir == 1) begin
		pos = pos - (speed << 1);
		if (pos <= 0) begin
	        dir = 0;
		end
	end
end
endmodule