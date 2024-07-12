module PriorityChoice_1 (out, outN, tripline);
   parameter OCODEWIDTH = 1;
   localparam CODEWIDTH=OCODEWIDTH-1;
   localparam SCODEWIDTH= (CODEWIDTH<1) ? 1 : CODEWIDTH;
   output reg             out;
   output reg [OCODEWIDTH-1:0] outN;
   input wire [(1<<OCODEWIDTH)-1:0] tripline;
   wire 			    left;
   wire [SCODEWIDTH-1:0] 	    leftN;
   wire 			    right;
   wire [SCODEWIDTH-1:0] 	    rightN;
   generate
      if(OCODEWIDTH==1) begin
	 assign left = tripline[1];
	 assign right = tripline[0];
	 always @(*) begin
	    out = left || right ;
	    if(right) begin outN = {1'b0}; end
	    else  begin outN = {1'b1}; end
	 end
      end else begin
	 PriorityChoice #(.OCODEWIDTH(OCODEWIDTH-1))
	 leftMap
	   (
	    .out(left),
	    .outN(leftN),
	    .tripline(tripline[(2<<CODEWIDTH)-1:(1<<CODEWIDTH)])
	    );
	 PriorityChoice #(.OCODEWIDTH(OCODEWIDTH-1))
	 rightMap
	   (
	    .out(right),
	    .outN(rightN),
	    .tripline(tripline[(1<<CODEWIDTH)-1:0])
	    );
	 always @(*) begin
	    if(right) begin
               out  = right;
               outN = {1'b0, rightN[OCODEWIDTH-2:0]};
	    end else begin
               out  = left;
               outN = {1'b1, leftN[OCODEWIDTH-2:0]};
	    end
	 end
      end
   endgenerate
endmodule