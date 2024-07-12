module prioenc #(
		 parameter REQ_LEN = 4,
		 parameter GRANT_LEN = 2
		 )
   (
    input wire [REQ_LEN-1:0]   in,
    output reg [GRANT_LEN-1:0] out,
    output reg 		       en
   );
   integer 		      i;
   always @ (*) begin
      en = 0;
      out = 0;
      for (i = REQ_LEN-1 ; i >= 0 ; i = i - 1) begin
	 if (~in[i]) begin
	    out = i;
	    en = 1;
	 end
      end
   end
endmodule