module uart_filter (
	input clk,
	input uart_rx,
	output reg tx_rx = 1'b0
);
	reg rx, meta;
	always @ (posedge clk)
		{rx, meta} <= {meta, uart_rx};
	wire sample0 = rx;
	reg sample1, sample2;
	always @ (posedge clk)
	begin
		{sample2, sample1} <= {sample1, sample0};
		if ((sample2 & sample1) | (sample1 & sample0) | (sample2 & sample0))
			tx_rx <= 1'b1;
		else
			tx_rx <= 1'b0;
	end
endmodule