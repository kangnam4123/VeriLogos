module _MUX_(A, B, S, Y);
input A, B, S;
output reg Y;
always @* begin
	if (S)
		Y = B;
	else
		Y = A;
end
endmodule