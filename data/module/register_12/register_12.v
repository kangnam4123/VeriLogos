module register_12 #(parameter SIZE = 16, parameter DEF = {SIZE{1'bx}}) (input clk, input [SIZE-1:0] i, output reg [SIZE-1:0] o, input [1:0] rw);
	initial o <= DEF;
	always @(clk) begin
		case (rw)
			2'b01 : begin
				o[SIZE/2-1 : 0] <= i[SIZE/2-1 : 0];
			end
			2'b10 : begin
				o[SIZE-1 : SIZE/2] <= i[SIZE-1 : SIZE/2];
			end
			2'b11 : begin
				o <= i;
			end
		endcase
	end
endmodule