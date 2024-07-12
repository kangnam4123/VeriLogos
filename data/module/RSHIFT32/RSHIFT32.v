module RSHIFT32 #(parameter SIZE = 32)(input [SIZE-1:0] in, 
    input [5:0] shift, input val,
    output reg [SIZE-1:0] out);
always @(in or shift or val) begin
    out = in >> shift;
	if(val)
	    out = out | ({SIZE-1 {1'b1} } << (SIZE-1-shift));
end	
endmodule