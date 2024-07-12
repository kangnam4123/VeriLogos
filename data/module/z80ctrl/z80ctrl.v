module z80ctrl(
	input [4:2] SDA_L,
	input [15:11] SDA_U,
	input nSDRD, nSDWR,
	input nMREQ, nIORQ,
	input nSDW,						
	input nRESET,
	output reg nZ80NMI,
	output nSDZ80R, nSDZ80W,	
	output nSDZ80CLR,				
	output nSDROM,
	output nSDMRD, nSDMWR,
	output nSDRD0, nSDRD1,
	output n2610CS,
	output n2610RD, n2610WR,
	output nZRAMCS
);
	reg nNMI_EN;
	wire nIORD, nIOWR;
	wire nNMI_SET, nNMI_RESET;
	assign nSDROM = &{SDA_U};
	assign nZRAMCS = ~nSDROM;
	assign nSDMRD = nMREQ | nSDRD;	
	assign nSDMWR = nMREQ | nSDWR;	
	assign nIORD = nIORQ | nSDRD;		
	assign nIOWR = nIORQ | nSDWR;		
	assign nSDZ80R = (nIORD | SDA_L[3] | SDA_L[2]);
	assign nSDZ80CLR = (nIOWR | SDA_L[3] | SDA_L[2]);
	assign n2610RD = (nIORD | SDA_L[3] | ~SDA_L[2]);
	assign n2610WR = (nIOWR | SDA_L[3] | ~SDA_L[2]);
	assign n2610CS = n2610RD & n2610WR;
	assign nSDRD0 = (nIORD | ~SDA_L[3] | SDA_L[2]);
	assign nNMI_SET = (nIOWR | ~SDA_L[3] | SDA_L[2]);
	assign nSDRD1 = (nIORD | ~SDA_L[3] | ~SDA_L[2]);
	assign nSDZ80W = (nIOWR | ~SDA_L[3] | ~SDA_L[2]);
	assign nNMI_RESET = nSDZ80R & nRESET;
	always @(posedge nNMI_SET or negedge nRESET)
	begin
		if (!nRESET)
			nNMI_EN <= 1'b1;
		else
			nNMI_EN <= SDA_L[4];
	end
	always @(posedge nSDW or negedge nNMI_RESET)
	begin
		if (!nNMI_RESET)
			nZ80NMI <= 1'b1;
		else
			nZ80NMI <= nNMI_EN;
	end
endmodule