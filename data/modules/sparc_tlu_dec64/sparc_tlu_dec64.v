module sparc_tlu_dec64(
   out, 
   in
   );
   input [5:0] in;
   output [63:0] out;
   wire [5:0] 	 in;
   reg [63:0] 	 out;
   integer 	 i;
   always @ (in)
     begin
	for (i=0;i<64;i=i+1)
	  begin
	     if (i[5:0] == in[5:0])
	       out[i] = 1'b1;
	     else
	       out[i] = 1'b0;
	  end
     end
endmodule