module c_gather
  (data_in, data_out);
   parameter in_width = 32;
   function automatic integer pop_count(input [0:in_width-1] argument);
      integer i;
      begin
	 pop_count = 0;
	 for(i = 0; i < in_width; i = i + 1)
	   pop_count = pop_count + argument[i];
      end
   endfunction
   parameter [0:in_width-1] mask = {in_width{1'b1}};
   localparam out_width = pop_count(mask);
   input [0:in_width-1] data_in;
   output [0:out_width-1] data_out;
   reg [0:out_width-1] 	  data_out;
   integer 		  idx1, idx2;
   always @(data_in)
     begin
	idx2 = 0;
	for(idx1 = 0; idx1 < in_width; idx1 = idx1 + 1)
	  if(mask[idx1] == 1'b1)
	    begin
	       data_out[idx2] = data_in[idx1];
	       idx2 = idx2 + 1;
	    end
     end
endmodule