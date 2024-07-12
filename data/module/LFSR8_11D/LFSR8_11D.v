module LFSR8_11D
(
	input wire       clk,
	output reg [7:0] LFSR = 255
);
	wire feedback = LFSR[7] ^ (LFSR[6:0] == 7'b0000000);
	always @(posedge clk) begin
		LFSR[0] <= feedback;
		LFSR[1] <= LFSR[0];
		LFSR[2] <= LFSR[1] ^ feedback;
		LFSR[3] <= LFSR[2] ^ feedback;
		LFSR[4] <= LFSR[3] ^ feedback;
		LFSR[5] <= LFSR[4];
		LFSR[6] <= LFSR[5];
		LFSR[7] <= LFSR[6];
	end
endmodule