module Instruction_Memory_1(
    output [15 : 0] data_out,
    input [15 : 0] address
    );
	reg [15 : 0] memory [255 : 0];
	initial
	begin
		memory[0] = 16'h6fbf;
		memory[1] = 16'h37e0;
		memory[2] = 16'h6901;
		memory[3] = 16'h6a01;
		memory[4] = 16'h6c01;
		memory[5] = 16'hdf40;
		memory[6] = 16'hdf80;
		memory[7] = 16'he944;
		memory[8] = 16'hdf40;
		memory[9] = 16'he451;
		memory[10] = 16'hdf80;
		memory[11] = 16'heb42;
		memory[12] = 16'h6101;
		memory[13] = 16'h10f9;
		memory[14] = 16'h6901;
		memory[15] = 16'h6a0f;
		memory[16] = 16'h7c20;
		memory[17] = 16'hea84;
		memory[18] = 16'hdf80;
		memory[19] = 16'h6a03;
		memory[20] = 16'hea87;
		memory[21] = 16'hdf80;
		memory[22] = 16'h6a04;
		memory[23] = 16'hea87;
		memory[24] = 16'hdf80;
		memory[25] = 16'hea87;
		memory[26] = 16'hdf80;
		memory[27] = 16'hea87;
		memory[28] = 16'hdf80;
		memory[29] = 16'h6901;
		memory[30] = 16'h6a0f;
		memory[31] = 16'h7c20;
		memory[32] = 16'hea84;
		memory[33] = 16'hea87;
		memory[34] = 16'h6900;
		memory[35] = 16'h6a04;
		memory[36] = 16'h6b0c;
		memory[37] = 16'h4901;
		memory[38] = 16'h6d0f;
		memory[39] = 16'he9ac;
		memory[40] = 16'hea84;
		memory[41] = 16'hec2d;
		memory[42] = 16'hdf80;
		memory[43] = 16'hea84;
		memory[44] = 16'hec2d;
		memory[45] = 16'hdf80;
		memory[46] = 16'hea84;
		memory[47] = 16'hec2d;
		memory[48] = 16'hdf80;
		memory[49] = 16'hea84;
		memory[50] = 16'hec2d;
		memory[51] = 16'hdf80;
		memory[52] = 16'h4901;
		memory[53] = 16'he9ac;
		memory[54] = 16'heb24;
		memory[55] = 16'hea86;
		memory[56] = 16'hec2d;
		memory[57] = 16'hdf80;
		memory[58] = 16'hea86;
		memory[59] = 16'hec2d;
		memory[60] = 16'hdf80;
		memory[61] = 16'hea86;
		memory[62] = 16'hec2d;
		memory[63] = 16'hdf80;
		memory[64] = 16'hea86;
		memory[65] = 16'hec2d;
		memory[66] = 16'hdf80;
		memory[67] = 16'heb26;
		memory[68] = 16'he96a;
		memory[69] = 16'h61df;
		memory[70] = 16'h8000;
	end
	assign data_out = memory[address];
endmodule