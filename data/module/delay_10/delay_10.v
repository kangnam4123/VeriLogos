module delay_10 #
(	
	parameter N = 8,
	parameter DELAY = 0
)
(
	input [N - 1:0] 	in,
	input					ce,
	input					clk,
	output [N - 1:0] 	out
);
reg [N-1:0] chain[0:DELAY];
integer i;
always @(posedge clk)
begin
	if(ce) begin
		for(i = DELAY; i > 0; i = i - 1)
		begin: register
			chain[i] <= chain[i - 1];
		end
		chain[0] <= in;
	end
end
assign out = chain[DELAY];
endmodule