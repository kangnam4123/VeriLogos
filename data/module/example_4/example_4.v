module example_4 (
	input  clk,
	input  SW1,
	input  SW2,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output AA, AB, AC, AD,
	output AE, AF, AG, CA
);
	localparam BITS = 8;
	localparam LOG2DELAY = 22;
	reg [BITS+LOG2DELAY-1:0] counter = 0;
	reg [BITS-1:0] outcnt;
	always @(posedge clk) begin
		counter <= counter + SW1 + SW2 + 1;
		outcnt <= counter >> LOG2DELAY;
	end
	assign {LED1, LED2, LED3, LED4} = outcnt ^ (outcnt >> 1);
	assign {AA, AB, AC, AD, AE, AF, AG} = ~(7'b 100_0000 >> outcnt[6:4]);
	assign CA = outcnt[7];
endmodule