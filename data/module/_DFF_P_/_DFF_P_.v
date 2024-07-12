module _DFF_P_(D, Q, C);
input D, C;
output reg Q;
always @(posedge C) begin
	Q <= D;
end
endmodule