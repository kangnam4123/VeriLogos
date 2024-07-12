module Mregister_8 (out, in, clock, enable_l);
output [7:0] out;
input [7:0] in;
input clock;
input enable_l;
    reg [7:0] out;
    reg [7:0] master;
    always @ (posedge clock) begin
	if((enable_l === 1'bx) || (clock === 1'bx))  begin
	    master = 8'bx;
	    #1 out = master;
	end
	else if (~enable_l) begin
	    master = in;
	    #1 out = master;
	end
    end
endmodule