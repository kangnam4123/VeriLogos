module simple_register #(parameter SIZE = 16) (input clk, input [SIZE-1:0] i, output reg [SIZE-1:0] o, input rw);
	always @(clk) begin
		if (rw) begin
			o <= i;
		end
	end
endmodule