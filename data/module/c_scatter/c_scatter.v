module c_scatter
  (data_in, dest_in, data_out);
   parameter out_width = 32;
   function integer pop_count(input [0:out_width-1] argument);
      integer i;
      begin
	 pop_count = 0;
	 for(i = 0; i < out_width; i = i + 1)
	   pop_count = pop_count + argument[i];
      end
   endfunction
   parameter [0:out_width-1] mask = {out_width{1'b1}};
   localparam in_width = pop_count(mask);
   input [0:in_width-1] data_in;
   input [0:out_width-1] dest_in;
   output [0:out_width-1] data_out;
   reg [0:out_width-1] 	  data_out;
   integer 		  idx1, idx2;
   always @(data_in)
     begin
	idx2 = 0;
	for(idx1 = 0; idx1 < out_width; idx1 = idx1 + 1)
	  if(mask[idx1] == 1'b1)
	    begin
	       data_out[idx1] = data_in[idx2];
	       idx2 = idx2 + 1;
	    end
	  else
	    data_out[idx1] = dest_in[idx1];
     end
endmodule