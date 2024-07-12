module event_tagger(
	strobe_channels,
	delta_channels,
	clk,
	reset_counter,
	capture_operate, counter_operate,
	data,
	ready
);
input [3:0] strobe_channels;
input [3:0] delta_channels;
input clk;
input reset_counter;
input capture_operate;
input counter_operate;
output ready; 
output [46:0] data;
reg [35:0] timer = 36'b0;
reg [3:0] old_delta = 3'b0;
reg ready = 0;
reg [46:0] data = 47'b0;
always @(posedge clk)
begin
	if (delta_channels != old_delta)			
	begin
		data[35:0] <= timer[35:0];
		data[39:36] <= delta_channels;
		data[44:40] <= 0;				
		data[45] <= 1;					
		data[46] <= (timer==1'b0) ? 1'b1 : 1'b0;	
		ready <= capture_operate;
		old_delta <= delta_channels;
	end
	else if (strobe_channels != 4'b0 || (timer == 36'b0 && counter_operate))
	begin
		data[35:0] <= timer[35:0];
		data[39:36] <= strobe_channels;
		data[44:40] <= 0;				
		data[45] <= 0;					
		data[46] <= (timer==36'b0) ? 1'b1 : 1'b0;	
		ready <= capture_operate;
	end
	else
	begin
		ready <= 0;
		data <= 47'bX;
	end
	timer <= reset_counter ? 0 : timer + counter_operate;
end
endmodule