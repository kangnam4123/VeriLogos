module finite_serial_adder #(
	parameter M = 4
) (
	input clk,
	input start,
	input ce,
	input [M-1:0] parallel_in,
	input serial_in,
	output reg [M-1:0] parallel_out = 0,
	output serial_out
);
	localparam TCQ = 1;
	always @(posedge clk)
		if (start)
			parallel_out <= #TCQ {parallel_in[0+:M-1], parallel_in[M-1]};
		else if (ce)
			parallel_out <= #TCQ {parallel_out[0+:M-1], parallel_out[M-1] ^ serial_in};
	assign serial_out = parallel_out[0];
endmodule