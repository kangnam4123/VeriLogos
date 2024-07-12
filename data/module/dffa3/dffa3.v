module dffa3(clk, arst, d, q);
input clk, arst, d;
output reg q;
always @(posedge clk or negedge arst) begin
	if (~(!arst))
		q <= d;
	else
		q <= 1;
end
endmodule