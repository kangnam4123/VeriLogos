module reg32(Rout, clr, clk, write_enable, write_value);
	input clr,clk, write_enable;
	input [31:0] write_value;
	output [31:0]Rout;
	reg[31:0] Rout;
	always @ (posedge clk)begin
		if(clr) begin
			Rout = 32'h00000000;
			end
		if(write_enable) begin
			Rout = write_value;
			end
	end
endmodule