module GP_SHREG(input nRST, input CLK, input IN, output OUTA, output OUTB);
	parameter OUTA_TAP = 1;
	parameter OUTA_INVERT = 0;
	parameter OUTB_TAP = 1;
	reg[15:0] shreg = 0;
	always @(posedge CLK, negedge nRST) begin
		if(!nRST)
			shreg = 0;
		else
			shreg <= {shreg[14:0], IN};
	end
	assign OUTA = (OUTA_INVERT) ? ~shreg[OUTA_TAP - 1] : shreg[OUTA_TAP - 1];
	assign OUTB = shreg[OUTB_TAP - 1];
endmodule