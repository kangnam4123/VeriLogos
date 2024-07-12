module CMP64 #(parameter SIZE = 64) (input [SIZE-1:0] in1, in2, 
    output reg equal, unequal, greater, lesser);
always @ (in1 or in2) begin
    if(in1 == in2) begin
	    equal = 1;
		unequal = 0;
		greater = 0;
		lesser = 0;
	end	
	else begin
	    equal = 0;
		unequal = 1;
	    if(in1 < in2) begin
		    greater = 0;
		    lesser = 1;
	    end	
	    else begin
		    greater = 1;
		    lesser = 0;
	    end	
	end	
end
endmodule