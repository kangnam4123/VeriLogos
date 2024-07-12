module Clock_Divider(input clock, input reset, output reg clock_out);
   reg [25:0] counter;
	initial 
		begin
			counter <= 26'b0;
			clock_out <= 1'b1;
		end
	always @(posedge clock or posedge reset)
	begin
		if(reset)
			begin
				counter <= 26'b0;
				clock_out <= 1'b1;
			end
		else
			if(counter == 26'd1134) 
				begin
					counter <= 26'b0;
					clock_out <= ~clock_out;
				end
			else
				begin
					counter <= counter+1;
				end
	end	
endmodule