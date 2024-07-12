module reset_12 (
	input clk_i,
	output nreset_o
);
reg [3:0] reset_counter = 4'b1111;
assign nreset_o = (reset_counter == 1'b0);
always @(posedge clk_i)
begin
	if( reset_counter > 1'b0 ) reset_counter = reset_counter - 1'b1;
end
endmodule