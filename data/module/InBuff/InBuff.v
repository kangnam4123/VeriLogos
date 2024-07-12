module InBuff #(parameter WIDTH = 16)(
	input clk,
	input [WIDTH-1:0] in,
	output reg [WIDTH-1:0] out,
	input read,
	input clkdiv,
	output reg outclk,
	output toread);
	reg [WIDTH-1:0] inbuf [20:0];
	reg [6:0] i;
	reg [15:0] counter = 0;
	reg oldread = 0;
	reg [6:0] bufpointer = 0;
	assign toread = (bufpointer > 0);
	always @(posedge clk) begin
		if (counter > clkdiv) begin
			outclk <= !outclk;
			counter <= 0;
			if (in != 0) begin
				for(i=1;i<21;i=i+1) begin
					inbuf[i] <= inbuf[i-1];
				end
				inbuf[0] <= in;
				bufpointer <= bufpointer + 1;
			end
		end
		if (!oldread) begin
			if (read) begin
				if(bufpointer > 0) begin
					out <= inbuf[bufpointer - 1];
					bufpointer <= bufpointer - 1;
					oldread <= 1;
				end
			end
		end
		if (!read) begin
			oldread <= 0;
		end
	end
endmodule