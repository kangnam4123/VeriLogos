module maskunit  #(
		   parameter REQ_LEN = 4,
		   parameter GRANT_LEN = 2
		   )
   (
    input wire [GRANT_LEN-1:0] mask,
    input wire [REQ_LEN-1:0]   in,
    output reg [REQ_LEN-1:0]   out
   );
   integer 		      i;
   always @ (*) begin
      out = 0;
      for (i = 0 ; i < REQ_LEN ; i = i+1) begin
	 out[i] = (mask < i) ? 1'b0 : 1'b1;
      end
   end
endmodule