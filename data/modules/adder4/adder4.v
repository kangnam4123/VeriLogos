module adder4 (clk, A, B, SUM);
input          clk;
input   [3:0]  A, B;
output  [4:0]  SUM;
reg 	[4:0]  SUM;
always @(posedge clk) begin
        SUM    	<= A + B;
end
endmodule