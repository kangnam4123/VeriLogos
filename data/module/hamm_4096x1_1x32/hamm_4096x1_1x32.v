module hamm_4096x1_1x32 (
   input  wire [31:0] data_i,
   input  wire [6:0]  addr_i,
   output wire [23:0] ecc_o
);
wire [31:0] d = data_i;
wire [7:0] data_xor = ^d;
assign ecc_o[0]    =  d[0] ^ d[2] ^ d[4] ^ d[6] ^ d[8] ^ d[10] ^ d[12] ^ d[14] ^ d[16] ^ d[18] ^ d[20] ^ d[22] ^ d[24] ^ d[26] ^ d[28] ^ d[30];
assign ecc_o[1]    =  d[0] ^ d[1] ^ d[4] ^ d[5] ^ d[8] ^ d[9]  ^ d[12] ^ d[13] ^ d[16] ^ d[17] ^ d[20] ^ d[21] ^ d[24] ^ d[25] ^ d[28] ^ d[29];
assign ecc_o[2]    =  d[0] ^ d[1] ^ d[2] ^ d[3] ^ d[8] ^ d[9]  ^ d[10] ^ d[11] ^ d[16] ^ d[17] ^ d[18] ^ d[19] ^ d[24] ^ d[25] ^ d[26] ^ d[27];
assign ecc_o[3]    =  d[0] ^ d[1] ^ d[2] ^ d[3] ^ d[4] ^ d[5]  ^ d[6]  ^ d[7]  ^ d[16] ^ d[17] ^ d[18] ^ d[19] ^ d[20] ^ d[21] ^ d[22] ^ d[23];
assign ecc_o[4]    =  d[0] ^ d[1] ^ d[2] ^ d[3] ^ d[4] ^ d[5]  ^ d[6]  ^ d[7]  ^ d[8]  ^ d[9]  ^ d[10] ^ d[11] ^ d[12] ^ d[13] ^ d[14] ^ d[15];
assign ecc_o[5]    = ~addr_i[0] & data_xor;
assign ecc_o[6]    = ~addr_i[1] & data_xor;
assign ecc_o[7]    = ~addr_i[2] & data_xor;
assign ecc_o[8]    = ~addr_i[3] & data_xor;
assign ecc_o[9]    = ~addr_i[4] & data_xor;
assign ecc_o[10]   = ~addr_i[5] & data_xor;
assign ecc_o[11]   = ~addr_i[6] & data_xor;
assign ecc_o[12+0]  =  d[1]  ^ d[3]  ^ d[5]  ^ d[7]  ^ d[9]  ^ d[11] ^ d[13] ^ d[15] ^ d[17] ^ d[19] ^ d[21] ^ d[23] ^ d[25] ^ d[27] ^ d[29] ^ d[31];
assign ecc_o[12+1]  =  d[2]  ^ d[3]  ^ d[6]  ^ d[7]  ^ d[10] ^ d[11] ^ d[14] ^ d[15] ^ d[18] ^ d[19] ^ d[22] ^ d[23] ^ d[26] ^ d[27] ^ d[30] ^ d[31];
assign ecc_o[12+2]  =  d[4]  ^ d[5]  ^ d[6]  ^ d[7]  ^ d[12] ^ d[13] ^ d[14] ^ d[15] ^ d[20] ^ d[21] ^ d[22] ^ d[23] ^ d[28] ^ d[29] ^ d[30] ^ d[31];
assign ecc_o[12+3]  =  d[8]  ^ d[9]  ^ d[10] ^ d[11] ^ d[12] ^ d[13] ^ d[14] ^ d[15] ^ d[24] ^ d[25] ^ d[26] ^ d[27] ^ d[28] ^ d[29] ^ d[30] ^ d[31];
assign ecc_o[12+4]  =  d[16] ^ d[17] ^ d[18] ^ d[19] ^ d[20] ^ d[21] ^ d[22] ^ d[23] ^ d[24] ^ d[25] ^ d[26] ^ d[27] ^ d[28] ^ d[29] ^ d[30] ^ d[31];
assign ecc_o[12+5]  =  addr_i[0] & data_xor;
assign ecc_o[12+6]  =  addr_i[1] & data_xor;
assign ecc_o[12+7]  =  addr_i[2] & data_xor;
assign ecc_o[12+8]  =  addr_i[3] & data_xor;
assign ecc_o[12+9]  =  addr_i[4] & data_xor;
assign ecc_o[12+10] =  addr_i[5] & data_xor;
assign ecc_o[12+11] =  addr_i[6] & data_xor;
endmodule