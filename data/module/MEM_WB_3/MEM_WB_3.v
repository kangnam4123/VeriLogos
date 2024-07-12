module MEM_WB_3(
		input clock,
		input reset,
		input debugEnable,
		input debugReset,
		input [4:0] writeRegister,
		input [31:0] aluOut,
		input [31:0] memoryOut,
		input regWrite,
		input memToReg,
		input eop,
		output reg [4:0] writeRegisterOut,
		output reg [31:0] aluOutOut,
		output reg [31:0] memoryOutOut,
		output reg regWriteOut,
		output reg memToRegOut,
		output reg eopOut
    );
	 	 always @(negedge clock,posedge reset)begin
		if(reset)begin
			writeRegisterOut<=0;
			aluOutOut<=0;
			memoryOutOut<=0;
			regWriteOut<=0;
			memToRegOut<=0;
			eopOut<=0;
		end
		else if (debugReset)begin
			writeRegisterOut<=0;
			aluOutOut<=0;
			memoryOutOut<=0;
			regWriteOut<=0;
			memToRegOut<=0;
			eopOut<=0;
		end
		else if(debugEnable) begin
			writeRegisterOut<=writeRegister;
			aluOutOut<=aluOut;
			memoryOutOut<=memoryOut;
			regWriteOut<=regWrite;
			memToRegOut<=memToReg;
			eopOut<=eop;
		end
	 end
endmodule