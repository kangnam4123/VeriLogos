module spiSlave #(
	parameter WIDTH = 8
)(
	input clk,
	input SS,
	input SCLK,
	input MOSI,
	output reg MISO = 0,
	input [WIDTH - 1:0] byteTX,
	input	newTXData,
	output reg [WIDTH - 1:0] byteRX = 0,
	output reg newSPIData = 0,
	output wire busy
);
reg txCaptured = 0;
reg rxCaptured = 1;
reg [1:0] SSShiftReg  = 2'b11;
reg [1:0] SCLKShiftReg  = 0;
reg [WIDTH - 1:0] byteTXBuffer;
reg [WIDTH - 1:0] byteRXBuffer = 8'b0;
assign busy = !rxCaptured || txCaptured;
always@(posedge clk) begin
	newSPIData <= 0 ;
	SSShiftReg <= {SSShiftReg[0], SS};
	if(SSShiftReg == 2'd0) begin
		rxCaptured <= 0;
		MISO <= byteTXBuffer[WIDTH-1];
		SCLKShiftReg <= {SCLKShiftReg[0], SCLK};
		if(SCLKShiftReg == 2'b01) 
			byteRXBuffer <= {byteRXBuffer[WIDTH-2:0], MOSI};
		else if(SCLKShiftReg == 2'b10) 
			byteTXBuffer <= {byteTXBuffer[WIDTH-2:0], 1'b0};
	end
	else if(SSShiftReg == 2'b11 && !rxCaptured) begin
		txCaptured <= 0;
		newSPIData <= 1;
		rxCaptured <= 1;
		byteRX <= byteRXBuffer;
	end
	if(newTXData) begin
		txCaptured <= 1;
		byteTXBuffer <= byteTX;
	end
end
endmodule