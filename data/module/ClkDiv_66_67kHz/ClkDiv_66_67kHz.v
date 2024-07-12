module ClkDiv_66_67kHz(
    CLK,										
    RST,										
    CLKOUT									
    );
	input CLK;
	input RST;
	output CLKOUT;
	reg CLKOUT = 1'b1;
	parameter cntEndVal = 7'b1011010;
	reg [6:0] clkCount = 7'b0000000;
	always @(posedge CLK) begin
			if(RST == 1'b1) begin
					CLKOUT <= 1'b0;
					clkCount <= 0;
			end
			else begin
					if(clkCount == cntEndVal) begin
							CLKOUT <= ~CLKOUT;
							clkCount <= 0;
					end
					else begin
							clkCount <= clkCount + 1'b1;
					end
			end
	end
endmodule