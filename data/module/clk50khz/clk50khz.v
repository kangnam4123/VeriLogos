module clk50khz(
	input wire clk,
	output wire outclk
);
	reg [9:0] cnt = 0;
	assign outclk = cnt == 1000;
	always @(posedge clk)
		if(outclk)
			cnt <= 0;
		else
			cnt <= cnt + 10'b1;
endmodule