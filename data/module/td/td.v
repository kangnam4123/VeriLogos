module td (
	   input vconst,
	   input b,
	   output reg q);
   always @ (vconst) begin
     q = vconst;
   end
endmodule