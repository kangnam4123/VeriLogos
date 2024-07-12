module Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Chroma_Upsampler (
	clk,
	reset,
	stream_in_data,
	stream_in_startofpacket,
	stream_in_endofpacket,
	stream_in_empty,
	stream_in_valid,
	stream_out_ready,
	stream_in_ready,
	stream_out_data,
	stream_out_startofpacket,
	stream_out_endofpacket,
	stream_out_empty,
	stream_out_valid
);
parameter IDW = 7; 
parameter ODW = 23; 
parameter IEW = 0; 
parameter OEW = 1; 
input						clk;
input						reset;
input			[IDW:0]	stream_in_data;
input						stream_in_startofpacket;
input						stream_in_endofpacket;
input			[IEW:0]	stream_in_empty;
input						stream_in_valid;
input						stream_out_ready;
output					stream_in_ready;
output reg	[ODW:0]	stream_out_data;
output reg				stream_out_startofpacket;
output reg				stream_out_endofpacket;
output reg	[OEW:0]	stream_out_empty;
output reg				stream_out_valid;
wire						transfer_data;
wire			[ODW:0]	converted_data;
wire						converted_startofpacket;
wire						converted_endofpacket;
wire			[OEW:0]	converted_empty;
wire						converted_valid;
reg			[IDW:0]	data;
reg						startofpacket;
reg						endofpacket;
reg			[IEW:0]	empty;
reg						valid;
always @(posedge clk)
begin
	if (reset)
	begin
		stream_out_data				<=  'h0;
		stream_out_startofpacket	<= 1'b0;
		stream_out_endofpacket		<= 1'b0;
		stream_out_empty				<=  'h0;
		stream_out_valid				<= 1'b0;
	end
	else if (transfer_data)
	begin
		stream_out_data				<= converted_data;
		stream_out_startofpacket	<= converted_startofpacket;
		stream_out_endofpacket		<= converted_endofpacket;
		stream_out_empty				<= converted_empty;
		stream_out_valid				<= converted_valid;
	end
end
always @(posedge clk)
begin
	if (reset)
	begin
		data								<=  'h0;
		startofpacket					<= 1'b0;
		endofpacket						<= 1'b0;
		empty								<=  'h0;
		valid								<= 1'b0;
	end
	else if (stream_in_ready)
	begin
		data								<= stream_in_data;
		startofpacket					<= stream_in_startofpacket;
		endofpacket						<= stream_in_endofpacket;
		empty								<= stream_in_empty;
		valid								<= stream_in_valid;
	end
	else if (transfer_data)
	begin
		data								<=  'h0;
		startofpacket					<= 1'b0;
		endofpacket						<= 1'b0;
		empty								<=  'h0;
		valid								<= 1'b0;
	end
end
assign stream_in_ready 			= stream_in_valid & (~valid | transfer_data);
assign transfer_data				= 
		~stream_out_valid | (stream_out_ready & stream_out_valid);
assign converted_data[23:16]	= 8'h80;
assign converted_data[15: 8]	= 8'h80;
assign converted_data[ 7: 0]	= data[7:0];
assign converted_startofpacket	= startofpacket;
assign converted_endofpacket	= endofpacket;
assign converted_empty			= empty;
assign converted_valid			= valid;
endmodule