module nios_system_Pixel_Buffer (
	clk,
	reset,
	address,
	byteenable,
	read,
	write,
	writedata,
	SRAM_DQ,
	SRAM_DPA,
	readdata,
	readdatavalid,
	waitrequest,
	SRAM_CLK,
	SRAM_ADDR,
	SRAM_ADSC_N,
	SRAM_ADSP_N,
	SRAM_ADV_N,
	SRAM_BE_N,
	SRAM_CE1_N,
	SRAM_CE2,
	SRAM_CE3_N,
	SRAM_GW_N,
	SRAM_OE_N,
	SRAM_WE_N	
);
input						clk;
input						reset;
input			[18: 0]	address;
input			[ 3: 0]	byteenable;
input						read;
input						write;
input			[31: 0]	writedata;
inout			[31: 0]	SRAM_DQ;		
inout			[ 3: 0]	SRAM_DPA; 		
output reg	[31: 0]	readdata;
output					readdatavalid;
output					waitrequest;
output					SRAM_CLK;		
output reg	[18: 0]	SRAM_ADDR;		
output reg				SRAM_ADSC_N;	
output reg				SRAM_ADSP_N;	
output reg				SRAM_ADV_N;		
output reg	[ 3: 0]	SRAM_BE_N;		
output reg				SRAM_CE1_N;		
output reg				SRAM_CE2;		
output reg				SRAM_CE3_N;		
output reg				SRAM_GW_N;		
output reg				SRAM_OE_N;		
output reg				SRAM_WE_N;		
wire			[ 3: 0]	internal_byteenable;
wire						start_write;
reg			[ 3: 0]	read_pipeline;
reg			[ 3: 0]	byteenable_reg;
reg			[31: 0]	writedata_reg;
always @(posedge clk)
begin
	readdata				<= SRAM_DQ;
	SRAM_ADDR			<= address;
	SRAM_ADSP_N			<= 1'b1;
	SRAM_ADSC_N			<= ~(read | start_write);
	SRAM_ADV_N			<= 1'b1;
	SRAM_BE_N[3]		<= ~internal_byteenable[3];
	SRAM_BE_N[2]		<= ~internal_byteenable[2];
	SRAM_BE_N[1]		<= ~internal_byteenable[1];
	SRAM_BE_N[0]		<= ~internal_byteenable[0];
	SRAM_CE1_N			<= ~(read | start_write);
	SRAM_CE2				<= (read | start_write);
	SRAM_CE3_N			<= ~(read | start_write);
	SRAM_GW_N			<= 1'b1;
	SRAM_OE_N			<= ~(read_pipeline[1]);
	SRAM_WE_N			<= ~start_write;
end
always @(posedge clk)
begin
	if (reset)
		read_pipeline	<= 4'h0;
	else
		read_pipeline	<= {read_pipeline[2:0], read};
end
always @(posedge clk)
begin
	if (reset)
		byteenable_reg	<= 4'h0;
	else
		byteenable_reg	<= internal_byteenable;
end
always @(posedge clk)
begin
	writedata_reg		<= writedata;
end
assign readdatavalid	= read_pipeline[3];
assign waitrequest		= write & (|(read_pipeline[2:0]));
assign SRAM_DQ[31:24]	= (internal_byteenable[3]) ? writedata_reg[31:24] : 8'hzz;
assign SRAM_DQ[23:16]	= (internal_byteenable[2]) ? writedata_reg[23:16] : 8'hzz;
assign SRAM_DQ[15: 8]	= (internal_byteenable[1]) ? writedata_reg[15: 8] : 8'hzz;
assign SRAM_DQ[ 7: 0]	= (internal_byteenable[0]) ? writedata_reg[ 7: 0] : 8'hzz;
assign SRAM_DPA			= 4'hz;
assign SRAM_CLK			= clk;
assign internal_byteenable[3]	= byteenable[3] & start_write;
assign internal_byteenable[2]	= byteenable[2] & start_write;
assign internal_byteenable[1]	= byteenable[1] & start_write;
assign internal_byteenable[0]	= byteenable[0] & start_write;
assign start_write				= write & ~(|(read_pipeline[2:0]));
endmodule