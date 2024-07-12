module synchronizer( 
    input clk_in,
    input clk_out,
    input in,
    output reg out = 0 );
reg a = 0;
reg b = 0;
always @(posedge clk_in)
	a <= in;
always @(posedge clk_out ) begin
	b <= a;
	out <= b;
end
endmodule