module iobdg_findfirst (
   vec_out, 
   vec_in
   );
   parameter VEC_WIDTH = 64;
   input [VEC_WIDTH-1:0]     vec_in;
   output [VEC_WIDTH-1:0]    vec_out;
   reg [VEC_WIDTH-1:0]       vec_out;
   reg [VEC_WIDTH-1:0]       selected;
   integer 		      i;
   always @(vec_in or selected)
     begin
     	selected[0] = vec_in[0];
	vec_out[0] = vec_in[0];
	for (i=1; i<VEC_WIDTH; i=i+1)
	  begin
	     selected[i] = vec_in[i] | selected[i-1];
	     vec_out[i] = vec_in[i] & ~selected[i-1];
	  end
     end
endmodule