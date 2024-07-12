module zero_ext (inp, res);
   parameter signed [31:0]  old_width = 4;
   parameter signed [31:0]  new_width = 2;
   input [old_width - 1 : 0] inp;
   output [new_width - 1 : 0] res;
   wire [new_width-1:0] result;
   genvar i;
   assign res = result;
   generate
     if (new_width > old_width)
       begin:u0
	  assign result = { {(new_width-old_width){1'b0}}, inp}; 
       end 
     else
       begin:u1
	  assign result[new_width-1:0] = inp[new_width-1:0];
       end 
    endgenerate
endmodule