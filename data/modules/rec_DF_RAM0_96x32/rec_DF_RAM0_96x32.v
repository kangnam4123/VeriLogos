module rec_DF_RAM0_96x32 (CK,ADR,DI,WEN,CEN,OEN,DOUT);
	input CK;
	input [6:0] ADR;
	input [31:0] DI;
	input WEN;
	input CEN;
	input OEN;
	output [31:0] DOUT;
	reg [31:0] DOUT;
	reg [31:0] RAM [0:95];
	always @ (posedge CK)
		if (!CEN &&  !WEN)
			RAM[ADR] <= DI;
	always @ (posedge CK)
		if (!CEN && !OEN)
			DOUT <= RAM[ADR];
endmodule