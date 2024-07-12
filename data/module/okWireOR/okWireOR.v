module okWireOR # (parameter N = 1)	(
	output reg  [64:0]     okEH,
	input  wire [N*65-1:0] okEHx
	);
	integer i;
	always @(okEHx)
	begin
		okEH = 0;
		for (i=0; i<N; i=i+1) begin: wireOR
			okEH = okEH | okEHx[ i*65 +: 65 ];
		end
	end
endmodule