module clk14khz(input wire inclk,
	output wire outclk);
	reg [11:0] cnt = 0;
	assign outclk = cnt == 3551;
	always @(posedge inclk)
		if(outclk)
			cnt <= 0;
		else
			cnt <= cnt + 12'b1;
endmodule