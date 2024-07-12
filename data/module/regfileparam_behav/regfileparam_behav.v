module regfileparam_behav 
	#(parameter BITSIZE = 16,
	  parameter ADDSIZE = 4)
	(output [BITSIZE-1:0] adat,
    output [BITSIZE-1:0] bdat,
	 output [BITSIZE-1:0] zeroDat,
    input [ADDSIZE-1:0] ra,	
    input [ADDSIZE-1:0] rb,	
    input [ADDSIZE-1:0] rw,	
    input [BITSIZE-1:0] wdat,
    input wren,
	 input clk, rst
    );
	 integer i;
	 reg [BITSIZE-1:0] array_reg [2**ADDSIZE-1:0]; 
	 always @(posedge clk, negedge rst) begin
		if(~rst) begin
			for(i = 0; i < 2**ADDSIZE; i = i + 1) begin
				array_reg[i] <= 0;
			end
		end
		else if(wren) begin
			array_reg[rw] <= wdat;
		end
	 end
	 assign adat = array_reg[ra];
	 assign bdat = array_reg[rb];
	 assign zeroDat = array_reg[0];
endmodule