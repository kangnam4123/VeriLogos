module altera_up_avalon_reset_from_locked_signal (
	locked,
	reset
);
input						locked;
output					reset;
assign reset	= ~locked;
endmodule