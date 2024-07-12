module joy_io(
	input nCTRL1ZONE,
	input nCTRL2ZONE,
	input nSTATUSBZONE,
	inout [15:0] M68K_DATA,
	input M68K_ADDR_A4,
	input [9:0] P1_IN,
	input [9:0] P2_IN,
	input nBITWD0,
	input nWP, nCD2, nCD1,
	input SYSTEM_MODE,
	output reg [2:0] P1_OUT,
	output reg [2:0] P2_OUT
);
	always @(negedge nBITWD0)
	begin
		if (!M68K_ADDR_A4) {P2_OUT, P1_OUT} <= M68K_DATA[5:0];
	end
	assign M68K_DATA[15:8] = nCTRL1ZONE ? 8'bzzzzzzzz : P1_IN[7:0];
	assign M68K_DATA[15:8] = nCTRL2ZONE ? 8'bzzzzzzzz : P2_IN[7:0];
	assign M68K_DATA[15:8] = nSTATUSBZONE ? 8'bzzzzzzzz : {SYSTEM_MODE, nWP, nCD2, nCD1, P2_IN[9:8], P1_IN[9:8]};
endmodule