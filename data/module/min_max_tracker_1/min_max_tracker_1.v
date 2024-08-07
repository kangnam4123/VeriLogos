module min_max_tracker_1(input clk, input [7:0] adc_d, input [7:0] threshold,
	output [7:0] min, output [7:0] max);
	reg [7:0] min_val = 255;
	reg [7:0] max_val = 0;
	reg [7:0] cur_min_val = 255;
	reg [7:0] cur_max_val = 0;
	reg [1:0] state = 0;
	always @(posedge clk)
	begin
		case (state)
		0:
			begin
				if (cur_max_val >= ({1'b0, adc_d} + threshold))
					state <= 2;
				else if (adc_d >= ({1'b0, cur_min_val} + threshold))
					state <= 1;
				if (cur_max_val <= adc_d)
					cur_max_val <= adc_d;
				else if (adc_d <= cur_min_val)
					cur_min_val <= adc_d;					
			end
		1:
			begin
				if (cur_max_val <= adc_d)
					cur_max_val <= adc_d;
				else if (({1'b0, adc_d} + threshold) <= cur_max_val) begin
					state <= 2;
					cur_min_val <= adc_d;
					max_val <= cur_max_val;
				end
			end
		2:
			begin
				if (adc_d <= cur_min_val)
					cur_min_val <= adc_d;					
				else if (adc_d >= ({1'b0, cur_min_val} + threshold)) begin
					state <= 1;
					cur_max_val <= adc_d;
					min_val <= cur_min_val;
				end
			end
		endcase
	end
	assign min = min_val;
	assign max = max_val;
endmodule