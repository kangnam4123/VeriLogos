module data_memory_6( memclock_in,address,writeData,memWrite,memRead,readData);
	input memclock_in;
   input [31:0] address;
   input [31:0] writeData;
   input memWrite;
   input memRead;
   output [31:0] readData;
	reg [31:0] memFile[0:127];
	reg [31:0] readData;
	integer i;
	initial 
	begin
		memFile[0] = 32'h00000000;
		memFile[1] = 32'h00000001;
		memFile[2] = 32'h00000002;
		memFile[3] = 32'h00000003;
		memFile[4] = 32'h00000004;
		memFile[5] = 32'h00000005;
		memFile[6] = 32'h00000006;
		memFile[7] = 32'h00000007;
		memFile[8] = 32'h00000008;
		memFile[9] = 32'h00000009;
		memFile[10] = 32'h0000000a;
		memFile[11] = 32'h0000000b;
		memFile[12] = 32'h0000000c;
		memFile[13] = 32'h0000000d;
		memFile[14] = 32'h0000000e;
		memFile[15] = 32'h0000000f;
		memFile[16] = 32'h00000010;
		memFile[17] = 32'h00000011;
		memFile[18] = 32'h00000012;
		memFile[19] = 32'h00000013;
		memFile[20] = 32'h00000014;
		memFile[21] = 32'h00000015;
		memFile[22] = 32'h00000016;
		memFile[23] = 32'h00000017;
		memFile[24] = 32'h00000018;
		memFile[25] = 32'h00000019;
		memFile[26] = 32'h0000001a;
		memFile[27] = 32'h0000001b;
		memFile[28] = 32'h0000001c;
		memFile[29] = 32'h0000001d;
		memFile[30] = 32'h0000001e;
		memFile[31] = 32'h0000001f;
	end
	always @ (memRead or address or memWrite) 
	begin
		readData = memFile[address];
	end
	always @ (negedge memclock_in) 
	begin
		if(memWrite)
			memFile[address] = writeData;
	end
endmodule