module rom_tristate(cs_, oe_, data_in, data_out);
	input cs_;
	input oe_;
	input [7:0] data_in;
	output [7:0] data_out;
assign data_out = (~cs_ & ~oe_) ? data_in : 8'bzzzzzzzz;
endmodule