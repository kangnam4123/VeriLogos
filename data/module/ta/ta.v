module ta (
	   input vconst,
	   input b,
	   output reg q);
   always @ (b or vconst) begin
      q = vconst | b;
   end
endmodule