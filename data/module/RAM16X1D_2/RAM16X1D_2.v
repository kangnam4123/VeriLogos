module RAM16X1D_2 (
    DPO,
    SPO,
    A0,
    A1,
    A2,
    A3,
    D,
    DPRA0,
    DPRA1,
    DPRA2,
    DPRA3,
    WCLK,
    WE
);
parameter dw = 1;
parameter aw = 4;
output DPO, SPO;
input DPRA0, DPRA1, DPRA2, DPRA3;
input A0, A1, A2, A3;
input D;
input WCLK;
input WE;
reg	[dw-1:0]	mem [(1<<aw)-1:0];	
assign DPO = mem[{DPRA3 , DPRA2 , DPRA1 , DPRA0}][dw-1:0];
assign SPO = mem[{A3 , A2 , A1 , A0}][dw-1:0];
always @(posedge WCLK)
	if (WE)
		mem[{A3 , A2 , A1 , A0}] <= #1 D;
endmodule