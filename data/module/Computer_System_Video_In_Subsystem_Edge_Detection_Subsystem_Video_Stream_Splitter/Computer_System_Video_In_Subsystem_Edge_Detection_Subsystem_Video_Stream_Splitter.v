module Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Video_Stream_Splitter (
	clk,
	reset,
	sync_ready,
	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_empty,
	stream_in_valid,
	stream_out_ready_0,
	stream_out_ready_1,
	stream_select,
	sync_data,
	sync_valid,
	stream_in_ready,
	stream_out_data_0,
	stream_out_startofpacket_0,
	stream_out_endofpacket_0,
	stream_out_empty_0,
	stream_out_valid_0,
	stream_out_data_1,
	stream_out_startofpacket_1,
	stream_out_endofpacket_1,
	stream_out_empty_1,
	stream_out_valid_1
);
parameter DW = 23; 
parameter EW = 1; 
input						clk;
input						reset;
input						sync_ready;
input			[DW: 0]	stream_in_data;
input						stream_in_startofpacket;
input						stream_in_endofpacket;
input			[EW: 0]	stream_in_empty;
input						stream_in_valid;
input						stream_out_ready_0;
input						stream_out_ready_1;
input						stream_select;
output reg				sync_data;
output reg				sync_valid;
output					stream_in_ready;
output reg	[DW: 0]	stream_out_data_0;
output reg				stream_out_startofpacket_0;
output reg				stream_out_endofpacket_0;
output reg	[EW: 0]	stream_out_empty_0;
output reg				stream_out_valid_0;
output reg	[DW: 0]	stream_out_data_1;
output reg				stream_out_startofpacket_1;
output reg				stream_out_endofpacket_1;
output reg	[EW: 0]	stream_out_empty_1;
output reg				stream_out_valid_1;
wire						enable_setting_stream_select;
reg						between_frames;
reg						stream_select_reg;
always @(posedge clk)
begin
	if (reset)
	begin
		sync_data	<= 1'b0;
		sync_valid	<= 1'b0;
	end
	else if (enable_setting_stream_select)
	begin
		sync_data	<= stream_select;
		sync_valid	<= 1'b1;
	end
	else if (sync_ready)
		sync_valid	<= 1'b0;
end
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data_0				<=  'h0;
		stream_out_startofpacket_0	<= 1'b0;
		stream_out_endofpacket_0	<= 1'b0;
		stream_out_empty_0			<=  'h0;
		stream_out_valid_0			<= 1'b0;
	end
	else if (stream_in_ready & ~stream_select_reg)
	begin
		stream_out_data_0				<= stream_in_data;
		stream_out_startofpacket_0	<= stream_in_startofpacket;
		stream_out_endofpacket_0	<= stream_in_endofpacket;
		stream_out_empty_0			<= stream_in_empty;
		stream_out_valid_0			<= stream_in_valid;
	end
	else if (stream_out_ready_0)
		stream_out_valid_0			<= 1'b0;
end
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data_1				<=  'h0;
		stream_out_startofpacket_1	<= 1'b0;
		stream_out_endofpacket_1	<= 1'b0;
		stream_out_empty_1			<=  'h0;
		stream_out_valid_1			<= 1'b0;
	end
	else if (stream_in_ready & stream_select_reg)
	begin
		stream_out_data_1				<= stream_in_data;
		stream_out_startofpacket_1	<= stream_in_startofpacket;
		stream_out_endofpacket_1	<= stream_in_endofpacket;
		stream_out_empty_1			<= stream_in_empty;
		stream_out_valid_1			<= stream_in_valid;
	end
	else if (stream_out_ready_1)
		stream_out_valid_1			<= 1'b0;
end
always @(posedge clk)
begin
	if (reset)
		between_frames <= 1'b1;
	else if (stream_in_ready & stream_in_endofpacket)
		between_frames <= 1'b1;
	else if (stream_in_ready & stream_in_startofpacket)
		between_frames <= 1'b0;
end
always @(posedge clk)
begin
	if (reset)
		stream_select_reg <= 1'b0;
	else if (enable_setting_stream_select)
		stream_select_reg <= stream_select;
end
assign stream_in_ready = (stream_select_reg) ? 
			stream_in_valid & (~stream_out_valid_1 | stream_out_ready_1) :
			stream_in_valid & (~stream_out_valid_0 | stream_out_ready_0);
assign enable_setting_stream_select = 
		  (stream_in_ready & stream_in_endofpacket) |
		(~(stream_in_ready & stream_in_startofpacket) & between_frames);
endmodule