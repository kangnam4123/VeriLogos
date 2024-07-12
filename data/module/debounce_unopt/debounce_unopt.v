module debounce_unopt #(parameter N=100000) (
		input wire clk,
		input wire in,
		output reg out
	);
	reg prev;
	reg [16:0] ctr;
	reg _o; 
	always @(posedge clk) begin
		if (in != prev) begin
			prev <= in;
			ctr <= 0;
		end else if (ctr == N) begin
			_o <= in;
		end else begin
			ctr <= ctr + 1;
		end
		out <= _o;
	end
endmodule