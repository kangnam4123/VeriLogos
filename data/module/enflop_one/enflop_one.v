module enflop_one (
		   input clk,
		   input d,
		   output reg q_r
		   );
   always @(posedge clk) q_r <= d;
endmodule