module c_spreader
  (data_in, data_out);
   parameter width = 32;
   function integer pop_count(input [0:width-1] argument);
      integer i;
      begin
	 pop_count = 0;
	 for(i = 0; i < width; i = i + 1)
	   pop_count = pop_count + argument[i];
      end
   endfunction
   parameter [0:width-1] mask = {width{1'b1}};
   localparam new_width = pop_count(mask);
   input [0:new_width-1] data_in;
   output [0:width-1] data_out;
   reg [0:width-1] data_out;
   integer 	   idx1, idx2;
   always @(data_in)
     begin
	idx2 = 0;
	for(idx1 = 0; idx1 < width; idx1 = idx1 + 1)
	  if(mask[idx1] == 1'b1)
	    begin
	       data_out[idx1] = data_in[idx2];
	       idx2 = idx2 + 1;
	    end
	  else
	    data_out[idx1] = 1'b0;
     end
endmodule