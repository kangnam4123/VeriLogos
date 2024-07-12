module reg3_2(D, Clock, Resetn, Q);
	input [2:0] D;
	input Clock, Resetn;
	output reg [2:0] Q;
	always @(posedge Clock or negedge Resetn)
		if (Resetn == 0) begin
			Q <= 3'b000;
		end else begin
			Q <= D;
		end
endmodule