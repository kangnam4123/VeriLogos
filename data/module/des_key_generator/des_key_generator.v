module des_key_generator
	(
		input wire clk,
		input wire reset,
		input wire 			enable_din,
		input wire 			source_sel_din,
		input wire 			round_shift_din,
		input wire  [0:55]	parity_drop_key_din,
		output wire [0:47]	round_key_dout
    );
	reg [0:27]	upper_key_reg;
	reg [0:27]	lower_key_reg;
	wire [0:27]	round_upper_key;
	wire [0:27]	round_lower_key;
	assign round_upper_key = (source_sel_din) ? upper_key_shifted : parity_drop_key_din[28:55];
	assign round_lower_key = (source_sel_din) ? lower_key_shifted : parity_drop_key_din[0:27];
	always @(posedge clk)
		if (reset)
			begin
				upper_key_reg <= {28{1'b0}};
				lower_key_reg <= {28{1'b0}};
			end
		else
			if (enable_din)
				begin
					upper_key_reg <= round_upper_key;
					lower_key_reg <= round_lower_key;
				end
	reg [0:27]	upper_key_shifted;
	reg [0:27]	lower_key_shifted;
	always @(*)
		case (round_shift_din)
			1'b0:
				begin
					upper_key_shifted = {upper_key_reg[1:27], upper_key_reg[0]};
					lower_key_shifted = {lower_key_reg[1:27], lower_key_reg[0]};
				end
			1'b1:
				begin
					upper_key_shifted = {upper_key_reg[2:27], upper_key_reg[0:1]};
					lower_key_shifted = {lower_key_reg[2:27], lower_key_reg[0:1]};
				end
		endcase
	wire [0:55]	rejoin_key;
	assign rejoin_key = {lower_key_shifted, upper_key_shifted};
	assign round_key_dout [0 +: 8] = 	{
											rejoin_key[13],
											rejoin_key[16],
											rejoin_key[10],
											rejoin_key[23],
											rejoin_key[0],
											rejoin_key[4],
											rejoin_key[2],
											rejoin_key[27]
										};
	assign round_key_dout [8 +: 8] = 	{
											rejoin_key[14],
											rejoin_key[5],
											rejoin_key[20],
											rejoin_key[9],
											rejoin_key[22],
											rejoin_key[18],
											rejoin_key[11],
											rejoin_key[3]
										};
	assign round_key_dout [16 +: 8] = 	{
											rejoin_key[25],
											rejoin_key[7],
											rejoin_key[15],
											rejoin_key[6],
											rejoin_key[26],
											rejoin_key[19],
											rejoin_key[12],
											rejoin_key[1]
										};
	assign round_key_dout [24 +: 8] = 	{
											rejoin_key[40],
											rejoin_key[51],
											rejoin_key[30],
											rejoin_key[36],
											rejoin_key[46],
											rejoin_key[54],
											rejoin_key[29],
											rejoin_key[39]
										};
	assign round_key_dout [32 +: 8] = 	{
											rejoin_key[50],
											rejoin_key[44],
											rejoin_key[32],
											rejoin_key[47],
											rejoin_key[43],
											rejoin_key[48],
											rejoin_key[38],
											rejoin_key[55]
										};
	assign round_key_dout [40 +: 8] = 	{
											rejoin_key[33],
											rejoin_key[52],
											rejoin_key[45],
											rejoin_key[41],
											rejoin_key[49],
											rejoin_key[35],
											rejoin_key[28],
											rejoin_key[31]
										};
endmodule