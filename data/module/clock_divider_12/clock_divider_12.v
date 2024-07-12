module clock_divider_12(input clock, input reset, input[5:0] counter, output reg clock_out);
	reg[5:0] temp_counter;
	initial 
		begin
			temp_counter <= 6'b0;
			clock_out <= 1'b0;
		end
	always @(posedge clock or posedge reset)
	begin
		if(reset)
			begin
				temp_counter <= 6'b0;
				clock_out <= 1'b0;
			end
		else
			if(temp_counter == counter) 
				begin
					temp_counter <= 6'b0;
					clock_out <= ~clock_out;
				end
			else
				begin
					temp_counter <= temp_counter + 1;
				end
	end	
endmodule