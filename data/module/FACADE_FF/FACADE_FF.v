module FACADE_FF #(
	parameter GSR = "ENABLED",
	parameter CEMUX = "1",
	parameter CLKMUX = "0",
	parameter LSRMUX = "LSR",
	parameter LSRONMUX = "LSRMUX",
	parameter SRMODE = "LSR_OVER_CE",
	parameter REGSET = "SET",
	parameter REGMODE = "FF"
) (
	input CLK, DI, LSR, CE,
	output reg Q
);
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
	wire muxlsron = (LSRONMUX == "LSRMUX") ? muxlsr : 1'b0;
	wire muxclk = (CLKMUX == "INV") ? ~CLK : CLK;
	wire srval = (REGSET == "SET") ? 1'b1 : 1'b0;
	initial Q = srval;
	generate
		if (REGMODE == "FF") begin
			if (SRMODE == "ASYNC") begin
				always @(posedge muxclk, posedge muxlsron)
					if (muxlsron)
						Q <= srval;
					else if (muxce)
						Q <= DI;
			end else begin
				always @(posedge muxclk)
					if (muxlsron)
						Q <= srval;
					else if (muxce)
						Q <= DI;
			end
		end else if (REGMODE == "LATCH") begin
			ERROR_UNSUPPORTED_FF_MODE error();
		end else begin
			ERROR_UNKNOWN_FF_MODE error();
		end
	endgenerate
endmodule