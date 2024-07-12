module ActivityLED(
		clk,
		rst_n,
		sig_in,
		led_out
	);
	input clk;
	input rst_n;
	input sig_in;
	output led_out;
	reg prevSigIn;
	reg [23:0] ledCounter;
	assign led_out = ledCounter[22];
	always @(posedge clk  or negedge rst_n) begin
		if(!rst_n) begin
			prevSigIn <= 'b0;
			ledCounter <= 'h0;
		end
		else begin
			prevSigIn <= sig_in;
			if(!ledCounter) begin
				if(sig_in && !prevSigIn) begin
					ledCounter <= 'h1;
				end
			end
			else begin
				ledCounter <= ledCounter + 'h1;
			end
		end
	end
endmodule