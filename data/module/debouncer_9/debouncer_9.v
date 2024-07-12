module debouncer_9(clk, button, clean);
input clk, button;
output reg clean;
parameter delay = 25'h16E3600; 
reg [24:0] delay_count; 
always@(posedge clk)
	if (button==1) begin
		if (delay_count==delay) begin
			delay_count=delay_count+1'b1;
			clean=1;
		end else begin
			if(delay_count==10'b11111_11111) begin
				clean=0;
				delay_count=10'b11111_11111;
			end else begin
				delay_count=delay_count+1'b1;
				clean=0;
			end
		end
	end else begin
		delay_count=0;
		clean=0;
	end
endmodule