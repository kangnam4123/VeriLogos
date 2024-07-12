module wire_test_case (array_out, clock, reset);
	output [15:0] array_out;
	input clock, reset;
	reg [3:0] readptr;
	reg [15:0] body [15:0];
	wire [15:0] array_out;
	assign array_out = body[readptr];
	always @(posedge clock) begin
		if (reset == 0) begin
			readptr <= 16'h0000;
			body[0] <= 16'h0001; 
			body[1] <= 16'h0002;
			body[2] <= 16'h0003;
			body[3] <= 16'h0005;
			body[4] <= 16'h0008;
			body[5] <= 16'h000D;
			body[6] <= 16'h0015;
		end
		else begin
			readptr <= readptr + 16'h0001;
		end
	end
endmodule