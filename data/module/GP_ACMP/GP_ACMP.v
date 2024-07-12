module GP_ACMP(input wire PWREN, input wire VIN, input wire VREF, output reg OUT);
	parameter BANDWIDTH = "HIGH";
	parameter VIN_ATTEN = 1;
	parameter VIN_ISRC_EN = 0;
	parameter HYSTERESIS = 0;
	initial OUT = 0;
endmodule