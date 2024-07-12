module fixeddivby32(
	input clk,
	input cein,
	output ceout);
	reg ceoutreg = 0;
	reg ceoutregs = 0;
	reg [4:0] counter = 0;
	assign ceout = ceoutregs;
	always @(*) begin
		if(counter == 31)
			ceoutreg <= cein;
		else
			ceoutreg <= 0;
	end
	always @(posedge clk) begin
		ceoutregs <= ceoutreg;
		if(cein)
			counter <= counter + 1;
	end
endmodule