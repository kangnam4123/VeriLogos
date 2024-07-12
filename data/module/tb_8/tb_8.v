module tb_8 (
	   input vconst,
	   input clk,
	   output reg q);
   always @ (posedge clk) begin
      q <= vconst;
   end
endmodule