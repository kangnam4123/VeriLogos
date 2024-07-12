module RSFF_1(input d, clk, set, reset, output reg q);
always @(posedge clk or posedge reset or posedge set)
    if(reset)
	    q <= 0;
	else if(set)
	    q <= 1;
	else
	    q <= d;
endmodule