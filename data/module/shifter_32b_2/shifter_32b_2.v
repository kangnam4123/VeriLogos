module shifter_32b_2 # (
	parameter LENGTH = 1
) (
	input clk,
	input [31:0] val_in,
	output [31:0] val_out
);
	genvar i;
	generate
		if (LENGTH >= 4)
		begin
			altshift_taps # (.number_of_taps(1), .tap_distance(LENGTH), .width(32)) shifttaps
				(.clken(1'b1), .aclr(1'b0), .clock(clk), .shiftin(val_in), .taps(), .shiftout(val_out) );
		end
		else
		begin
			for (i = 0; i < LENGTH; i = i + 1) begin : TAPS
				reg [31:0] r;
				wire [31:0] prev;
				if (i == 0)
					assign prev = val_in;
				else
					assign prev = TAPS[i-1].r;
				always @ (posedge clk)
					r <= prev;
			end
			assign val_out = TAPS[LENGTH-1].r;
		end
	endgenerate
endmodule