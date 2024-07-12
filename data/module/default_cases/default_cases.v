module default_cases(a, y);
input [2:0] a;
output reg [3:0] y;
always @* begin
	case (a)
		3'b000, 3'b111: y <= 0;
		default: y <= 4;
		3'b001: y <= 1;
		3'b010: y <= 2;
		3'b100: y <= 3;
	endcase
end
endmodule