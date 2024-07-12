module LATCH_4(input d, enable, output reg q);
always @( d or enable)
    if(enable)
	    q <= d;
endmodule