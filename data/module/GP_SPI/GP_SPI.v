module GP_SPI(
	input SCK,
	inout SDAT,
	input CSN,
	input[7:0] TXD_HIGH,
	input[7:0] TXD_LOW,
	output reg[7:0] RXD_HIGH,
	output reg[7:0] RXD_LOW,
	output reg INT);
	initial RXD_HIGH = 0;
	initial RXD_LOW = 0;
	initial INT = 0;
	parameter DATA_WIDTH = 8;		
	parameter SPI_CPHA = 0;			
	parameter SPI_CPOL = 0;			
	parameter DIRECTION = "INPUT";	
endmodule