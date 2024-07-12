module NAND8_reducer(
	InY,
	Reduced_NAND
);
input wire	[7:0] InY;
output wire	Reduced_NAND;
wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
assign	SYNTHESIZED_WIRE_5 = ~(InY[4] | InY[5]);
assign	SYNTHESIZED_WIRE_4 = ~(InY[2] | InY[3]);
assign	SYNTHESIZED_WIRE_2 =  ~InY[7];
assign	SYNTHESIZED_WIRE_3 = ~(InY[0] | InY[1]);
assign	Reduced_NAND = ~(SYNTHESIZED_WIRE_0 | SYNTHESIZED_WIRE_1);
assign	SYNTHESIZED_WIRE_6 = ~(InY[6] | SYNTHESIZED_WIRE_2);
assign	SYNTHESIZED_WIRE_0 = ~(SYNTHESIZED_WIRE_3 & SYNTHESIZED_WIRE_4);
assign	SYNTHESIZED_WIRE_1 = ~(SYNTHESIZED_WIRE_5 & SYNTHESIZED_WIRE_6);
endmodule