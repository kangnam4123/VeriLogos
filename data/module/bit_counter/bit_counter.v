module bit_counter(clk, rstn, ce, bitnum);
	input clk;
	input rstn;
	input ce;
	output [3:0] bitnum;
	reg [3:0] bitnum_int;
	assign bitnum = bitnum_int;
	always @(posedge clk or negedge rstn) begin
		if(rstn == 0)
			bitnum_int <= 0;
		else begin
			if(ce) begin
				if(bitnum_int == 9)
					bitnum_int <= 0; 
				else
					bitnum_int <= bitnum_int + 1'b1;
			end
		end
	end	
endmodule