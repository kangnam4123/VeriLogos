module PC1(
    input [63:0] Din,
    output [55:0] Dout
    );
assign Dout = {Din[7], Din[15], Din[23], Din[31], Din[39], Din[47], Din[55], Din[63], Din[6], Din[14], Din[22], Din[30], Din[38], Din[46], Din[54], Din[62], Din[5], Din[13], Din[21], Din[29], Din[37], Din[45], Din[53], Din[61], Din[4], Din[12], Din[20], Din[28], Din[1], Din[9], Din[17], Din[25], Din[33], Din[41], Din[49], Din[57], Din[2], Din[10], Din[18], Din[26], Din[34], Din[42], Din[50], Din[58], Din[3], Din[11], Din[19], Din[27], Din[35], Din[43], Din[51], Din[59], Din[36], Din[44], Din[52], Din[60]};
endmodule