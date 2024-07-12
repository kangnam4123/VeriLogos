module dffa4(clk, arst1, arst2, arst3, d, q);
input clk, arst1, arst2, arst3, d;
output reg q;
always @(posedge clk, posedge arst1, posedge arst2, negedge arst3) begin
	if (arst1)
		q <= 0;
	else if (arst2)
		q <= 0;
	else if (!arst3)
		q <= 0;
	else
		q <= d;
end
endmodule