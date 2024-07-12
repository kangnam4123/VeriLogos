module reverse_words #(
	parameter M = 4,
	parameter WORDS = 1
) (
	input [M*WORDS-1:0] in,
	output [M*WORDS-1:0] out
);
	genvar i;
	for (i = 0; i < WORDS; i = i + 1) begin : REV
		assign out[i*M+:M] = in[(WORDS-i-1)*M+:M];
	end
endmodule