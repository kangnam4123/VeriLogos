module register4(clk, out, in, write, reset);  
	output reg [3:0] out;
	input      [3:0] in;
	input      clk, write, reset;
	always@(posedge clk) begin
		if(reset==0) begin
			out = 4'b0;
		end
		else if(write == 1'b0) begin
			out = in;
		end
	end
endmodule