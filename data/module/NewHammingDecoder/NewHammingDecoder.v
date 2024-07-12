module NewHammingDecoder(H, D);
	input [6:0] H;
	output [3:0] D;
	assign D[3] = (H[6]^H[5]^H[4]^H[2])&(H[6]^H[5]^H[3]^H[1])&(H[6]^H[4]^H[3]^H[0])  ? ~H[6] : H[6];
	assign D[2] = (H[6]^H[5]^H[4]^H[2])&(H[6]^H[5]^H[3]^H[1])&!(H[6]^H[4]^H[3]^H[0]) ? ~H[5] : H[5];
	assign D[1] = (H[6]^H[5]^H[4]^H[2])&!(H[6]^H[5]^H[3]^H[1])&(H[6]^H[4]^H[3]^H[0]) ? ~H[4] : H[4];
	assign D[0] = !(H[6]^H[5]^H[4]^H[2])&(H[6]^H[5]^H[3]^H[1])&(H[6]^H[4]^H[3]^H[0]) ? ~H[3] : H[3];
endmodule