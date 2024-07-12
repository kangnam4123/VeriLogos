module usb3_crc_dpp8 (
input 	wire	[7:0]	di,
input	wire	[31:0]	q,
output	wire	[31:0]	crc_out,
input	wire			rst,
input	wire			clk
);
wire [31:0]	c;
wire [7:0] d = {	di[0 ],di[1 ],di[2 ],di[3 ],di[4 ],di[5 ],di[6 ],di[7]};
assign crc_out = ~{	c[0],  c[1],  c[2],  c[3],  c[4],  c[5],  c[6],  c[7], 
					c[8],  c[9],  c[10], c[11], c[12], c[13], c[14], c[15],
					c[16], c[17], c[18], c[19], c[20], c[21], c[22], c[23], 
					c[24], c[25], c[26], c[27], c[28], c[29], c[30], c[31]};
assign	c[0] = q[24] ^ q[30] ^ d[0] ^ d[6];
assign	c[1] = q[24] ^ q[25] ^ q[30] ^ q[31] ^ d[0] ^ d[1] ^ d[6] ^ d[7];
assign	c[2] = q[24] ^ q[25] ^ q[26] ^ q[30] ^ q[31] ^ d[0] ^ d[1] ^ d[2] ^ d[6] ^ d[7];
assign	c[3] = q[25] ^ q[26] ^ q[27] ^ q[31] ^ d[1] ^ d[2] ^ d[3] ^ d[7];
assign	c[4] = q[24] ^ q[26] ^ q[27] ^ q[28] ^ q[30] ^ d[0] ^ d[2] ^ d[3] ^ d[4] ^ d[6];
assign	c[5] = q[24] ^ q[25] ^ q[27] ^ q[28] ^ q[29] ^ q[30] ^ q[31] ^ d[0] ^ d[1] ^ d[3] ^ d[4] ^ d[5] ^ d[6] ^ d[7];
assign	c[6] = q[25] ^ q[26] ^ q[28] ^ q[29] ^ q[30] ^ q[31] ^ d[1] ^ d[2] ^ d[4] ^ d[5] ^ d[6] ^ d[7];
assign	c[7] = q[24] ^ q[26] ^ q[27] ^ q[29] ^ q[31] ^ d[0] ^ d[2] ^ d[3] ^ d[5] ^ d[7];
assign	c[8] = q[0] ^ q[24] ^ q[25] ^ q[27] ^ q[28] ^ d[0] ^ d[1] ^ d[3] ^ d[4];
assign	c[9] = q[1] ^ q[25] ^ q[26] ^ q[28] ^ q[29] ^ d[1] ^ d[2] ^ d[4] ^ d[5];
assign	c[10] = q[2] ^ q[24] ^ q[26] ^ q[27] ^ q[29] ^ d[0] ^ d[2] ^ d[3] ^ d[5];
assign	c[11] = q[3] ^ q[24] ^ q[25] ^ q[27] ^ q[28] ^ d[0] ^ d[1] ^ d[3] ^ d[4];
assign	c[12] = q[4] ^ q[24] ^ q[25] ^ q[26] ^ q[28] ^ q[29] ^ q[30] ^ d[0] ^ d[1] ^ d[2] ^ d[4] ^ d[5] ^ d[6];
assign	c[13] = q[5] ^ q[25] ^ q[26] ^ q[27] ^ q[29] ^ q[30] ^ q[31] ^ d[1] ^ d[2] ^ d[3] ^ d[5] ^ d[6] ^ d[7];
assign	c[14] = q[6] ^ q[26] ^ q[27] ^ q[28] ^ q[30] ^ q[31] ^ d[2] ^ d[3] ^ d[4] ^ d[6] ^ d[7];
assign	c[15] = q[7] ^ q[27] ^ q[28] ^ q[29] ^ q[31] ^ d[3] ^ d[4] ^ d[5] ^ d[7];
assign	c[16] = q[8] ^ q[24] ^ q[28] ^ q[29] ^ d[0] ^ d[4] ^ d[5];
assign	c[17] = q[9] ^ q[25] ^ q[29] ^ q[30] ^ d[1] ^ d[5] ^ d[6];
assign	c[18] = q[10] ^ q[26] ^ q[30] ^ q[31] ^ d[2] ^ d[6] ^ d[7];
assign	c[19] = q[11] ^ q[27] ^ q[31] ^ d[3] ^ d[7];
assign	c[20] = q[12] ^ q[28] ^ d[4];
assign	c[21] = q[13] ^ q[29] ^ d[5];
assign	c[22] = q[14] ^ q[24] ^ d[0];
assign	c[23] = q[15] ^ q[24] ^ q[25] ^ q[30] ^ d[0] ^ d[1] ^ d[6];
assign	c[24] = q[16] ^ q[25] ^ q[26] ^ q[31] ^ d[1] ^ d[2] ^ d[7];
assign	c[25] = q[17] ^ q[26] ^ q[27] ^ d[2] ^ d[3];
assign	c[26] = q[18] ^ q[24] ^ q[27] ^ q[28] ^ q[30] ^ d[0] ^ d[3] ^ d[4] ^ d[6];
assign	c[27] = q[19] ^ q[25] ^ q[28] ^ q[29] ^ q[31] ^ d[1] ^ d[4] ^ d[5] ^ d[7];
assign	c[28] = q[20] ^ q[26] ^ q[29] ^ q[30] ^ d[2] ^ d[5] ^ d[6];
assign	c[29] = q[21] ^ q[27] ^ q[30] ^ q[31] ^ d[3] ^ d[6] ^ d[7];
assign	c[30] = q[22] ^ q[28] ^ q[31] ^ d[4] ^ d[7];
assign	c[31] = q[23] ^ q[29] ^ d[5];
endmodule