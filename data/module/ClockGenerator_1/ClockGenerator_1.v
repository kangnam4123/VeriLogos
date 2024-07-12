module ClockGenerator_1(rst_n, clk, divClk);
input rst_n, clk;
output reg divClk;
parameter clkDiv = 8'b0001_1111; 
reg [7:0] clkCount;
always @(posedge clk)
begin
	if (~rst_n)
	begin
		divClk <= 1'b0;
		clkCount <= 8'b0;
	end
	else if (clkCount == clkDiv)
	begin
		divClk <= ~divClk;
		clkCount <= 8'b0;
	end
	else
		clkCount <= clkCount + 8'b1;
end
endmodule