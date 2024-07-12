module OXIDE_FF(input CLK, LSR, CE, DI, M, output reg Q);
	parameter GSR = "ENABLED";
	parameter [127:0] CEMUX = "1";
	parameter CLKMUX = "CLK";
	parameter LSRMUX = "LSR";
	parameter REGDDR = "DISABLED";
	parameter SRMODE = "LSR_OVER_CE";
	parameter REGSET = "RESET";
	parameter [127:0] LSRMODE = "LSR";
	wire muxce;
	generate
		case (CEMUX)
			"1": assign muxce = 1'b1;
			"0": assign muxce = 1'b0;
			"INV": assign muxce = ~CE;
			default: assign muxce = CE;
		endcase
	endgenerate
	wire muxlsr = (LSRMUX == "INV") ? ~LSR : LSR;
	wire muxclk = (CLKMUX == "INV") ? ~CLK : CLK;
	wire srval;
	generate
		if (LSRMODE == "PRLD")
			assign srval = M;
		else
			assign srval = (REGSET == "SET") ? 1'b1 : 1'b0;
	endgenerate
	initial Q = srval;
	generate
		if (REGDDR == "ENABLED") begin
			if (SRMODE == "ASYNC") begin
				always @(posedge muxclk, negedge muxclk, posedge muxlsr)
					if (muxlsr)
						Q <= srval;
					else if (muxce)
						Q <= DI;
			end else begin
				always @(posedge muxclk, negedge muxclk)
					if (muxlsr)
						Q <= srval;
					else if (muxce)
						Q <= DI;
			end
		end else begin
			if (SRMODE == "ASYNC") begin
				always @(posedge muxclk, posedge muxlsr)
					if (muxlsr)
						Q <= srval;
					else if (muxce)
						Q <= DI;
			end else begin
				always @(posedge muxclk)
					if (muxlsr)
						Q <= srval;
					else if (muxce)
						Q <= DI;
			end
		end
	endgenerate
endmodule