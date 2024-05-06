module rescale_shift (IsLeftShift,shift_input,shift_len,shift_output);
	input IsLeftShift;
	input signed [15:0] shift_input;
	input [3:0] shift_len;
	output signed [15:0] shift_output;
	assign shift_output = (IsLeftShift == 1'b1)? (shift_input <<< shift_len):(shift_input >>> shift_len);
endmodule