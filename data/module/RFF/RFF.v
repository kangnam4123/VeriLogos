module RFF(input d, clk, reset, output reg q);
always @(posedge clk or posedge reset)
    if(reset)
	    q <= 0;
	else
	    q <= d;
endmodule