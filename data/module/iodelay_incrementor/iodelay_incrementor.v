module iodelay_incrementor(
	input clk40,
	input rst,
	input count_trig,
	input  [5:0] spec_delay,
	output reg inc_en,
	output reg [5:0] actual_delay
);
always @(posedge clk40) begin
	if (rst) begin
		inc_en <= 0;
		actual_delay <= 0;
	end else begin
		if (inc_en) begin
			if (actual_delay == spec_delay) begin
				inc_en <= 0;
			end else begin
				actual_delay <= actual_delay + 1;
			end
		end else begin
			if (count_trig) begin
				inc_en <= 1;
			end
		end
	end
end
endmodule