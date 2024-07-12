module LSHIFT1 #(parameter SIZE = 1)(input in, shift, val, output reg out);
always @ (in, shift, val) begin
    if(shift)
	    out = val;
	else 
	    out = in;
end
endmodule