module REGBANK_banco_1 #(parameter addr_bits=5, word_wide=32)(
	input clock,
	input regWrite,
	input [addr_bits-1:0] readReg1,
	input [addr_bits-1:0] readReg2,
	input [addr_bits-1:0] writeReg,
	input [word_wide-1:0] writeData,
	output [word_wide-1:0] readData1,
	output [word_wide-1:0] readData2
);
	localparam bank_depth = 1 << addr_bits;
	reg [word_wide-1:0] banco [bank_depth-1:0];
	assign readData1 = banco[readReg1];
	assign readData2 = banco[readReg2];
	always@(posedge clock) begin
		if (regWrite) begin
			banco[writeReg] = writeData;
		end
	end
endmodule