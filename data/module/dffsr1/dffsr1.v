module dffsr1(clk, arst, d, q);
input clk, arst, d;
output reg q;
always @(posedge clk, posedge arst) begin
	if (arst)
		q <= d^d; 
	else
		q <= d;
end
endmodule