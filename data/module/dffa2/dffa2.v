module dffa2(clk, arst, d, q);
input clk, arst, d;
output reg q;
always @(posedge clk or negedge arst) begin
	if (!arst)
		q <= 0;
	else
		q <= d;
end
endmodule