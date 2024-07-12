module comparer #(parameter width=63)(
	input [width:0] Din,
	input [width:0] test,
	input CLK,
	input reset,
	output [width:0] Dout,
	output good
);
reg [width:0] Dtmp;
reg tmpgood;
always @(posedge CLK)
begin
	if (reset == 1)
	begin
		Dtmp <= 64'b0;
		tmpgood <= 1;
	end
	else
	begin
		Dtmp <= Din;
		if (test != 64'b0)
			tmpgood <= 1;
		else
			tmpgood <= 0;
	end
end
assign Dout = Dtmp;
assign good = ~tmpgood;
endmodule