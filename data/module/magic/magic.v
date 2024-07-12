module magic
	#(parameter width = 16,
	  parameter shift = $clog2(width))
	(input [width-1:0]h,
	 input [1:0]type,
	 input left,
	 output reg [width-1:0]z);
	localparam NS=0, LO=1, AR=2, RO=3;
	always @(*) if (left) begin
		case(type)
		NS: z <= h;
		LO: z <= h <<  shift;
		AR: z <= h <<< shift;
		RO: z <= { h[width-1-shift:0], h[width-1:width-1-shift-1] };
		endcase
	end else begin
		case(type)
		NS: z <= h;
		LO: z <= h >>  shift;
		AR: z <= h >>> shift;
		RO: z <= { h[width-1:width-1-shift-1], h[width-1-shift:0] };
		endcase
	end
endmodule