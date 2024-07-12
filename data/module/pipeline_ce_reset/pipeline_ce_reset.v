module pipeline_ce_reset #(
	parameter STAGES = 0
) (
	input clk,
	input ce,
	input reset,
	input i,
	output o
);
	localparam TCQ = 1;
	if (!STAGES)
		assign o = i;
	else begin
		reg [STAGES-1:0] pipeline = 0;
		assign o = pipeline[STAGES-1];
		always @(posedge clk)
			if (reset)
				pipeline <= #TCQ pipeline << 1;
			else if (ce)
				pipeline <= #TCQ (pipeline << 1) | i;
	end
endmodule