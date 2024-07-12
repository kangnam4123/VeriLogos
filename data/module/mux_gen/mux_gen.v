module mux_gen #(parameter word_sz=8, channels=3)
	(	output [word_sz-1:0] out,
		input [(word_sz * channels) - 1:0] in,
		input [$clog2(channels)-1:0] sel);
	wire [word_sz-1:0] in_arr [channels-1:0];
	assign out = in_arr[sel];
	generate
		genvar i;
		for(i = 0; i < channels; i = i + 1) begin
			assign in_arr[i] = in[(i * word_sz) +: word_sz];
		end
	endgenerate
endmodule