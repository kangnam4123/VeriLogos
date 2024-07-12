module altera_up_video_scaler_multiply_width_1 (
	clk,
	reset,
	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_valid,
	stream_out_ready,
	stream_in_ready,
	stream_out_data,
	stream_out_startofpacket,
	stream_out_endofpacket,
	stream_out_valid
);
parameter DW	=  15; 
parameter CW	=   0; 
input						clk;
input						reset;
input			[DW: 0]	stream_in_data;
input						stream_in_startofpacket;
input						stream_in_endofpacket;
input						stream_in_valid;
input						stream_out_ready;
output					stream_in_ready;
output reg	[DW: 0]	stream_out_data;
output reg				stream_out_startofpacket;
output reg				stream_out_endofpacket;
output reg				stream_out_valid;
reg			[DW: 0]	data;
reg						startofpacket;
reg						endofpacket;
reg						valid;
reg			[CW: 0]	enlarge_width_counter;
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data					<=  'h0;
		stream_out_startofpacket		<= 1'b0;
		stream_out_endofpacket			<= 1'b0;
		stream_out_valid					<= 1'b0;
	end
	else if (stream_out_ready | ~stream_out_valid)
	begin
		stream_out_data					<= data;
		if (|(enlarge_width_counter))
			stream_out_startofpacket	<= 1'b0;
		else
			stream_out_startofpacket	<= startofpacket;
		if (&(enlarge_width_counter))
			stream_out_endofpacket		<= endofpacket;
		else
			stream_out_endofpacket		<= 1'b0;
		stream_out_valid					<= valid;
	end
end
always @(posedge clk)
begin
	if (reset)
	begin
		data									<=  'h0;
		startofpacket						<= 1'b0;
		endofpacket							<= 1'b0;
		valid									<= 1'b0;
	end
	else if (stream_in_ready)
	begin
		data									<= stream_in_data;
		startofpacket						<= stream_in_startofpacket;
		endofpacket							<= stream_in_endofpacket;
		valid									<= stream_in_valid;
	end
end
always @(posedge clk)
begin
	if (reset)
		enlarge_width_counter <= 'h0;
	else if ((stream_out_ready | ~stream_out_valid) & valid)
		enlarge_width_counter <= enlarge_width_counter + 1;
end
assign stream_in_ready	= (~valid) | 
	((&(enlarge_width_counter)) & (stream_out_ready | ~stream_out_valid));
endmodule