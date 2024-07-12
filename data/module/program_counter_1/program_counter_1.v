module program_counter_1 #(parameter SIZE = 16) (input clk, input [SIZE-1:0] i, output reg [SIZE-1:0] o, input rw, input [1:0] inc);
	initial o <= 0;
	always @(clk) begin
		case (inc)
			2'b00 : begin
				if (rw)
					o <= i;
			end
			2'b01 : o <= o + 2;
			2'b10 : o <= o + 4;
			2'b11 : o <= o + 6;
		endcase
	end
endmodule