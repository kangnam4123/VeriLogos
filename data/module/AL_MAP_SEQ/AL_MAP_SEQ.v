module AL_MAP_SEQ (
	output reg q,
	input ce,
	input clk,
	input sr,
	input d
);
	parameter DFFMODE = "FF"; 
	parameter REGSET = "RESET"; 
	parameter SRMUX = "SR"; 
	parameter SRMODE = "SYNC"; 
	wire srmux;
	generate
		case (SRMUX)
			"SR": assign srmux = sr;
			"INV": assign srmux = ~sr;
			default: assign srmux = sr;
		endcase
	endgenerate
	wire regset;
	generate
		case (REGSET)
			"RESET": assign regset = 1'b0;
			"SET": assign regset = 1'b1;
			default: assign regset = 1'b0;
		endcase
	endgenerate
	initial q = regset;
	generate
		if (DFFMODE == "FF")
		begin
			if (SRMODE == "ASYNC")
			begin
				always @(posedge clk, posedge srmux)
					if (srmux)
						q <= regset;
					else if (ce)
						q <= d;
			end
			else
			begin
				always @(posedge clk)
					if (srmux)
						q <= regset;
					else if (ce)
						q <= d;
			end
		end
		else
		begin
			if (SRMODE == "ASYNC")
			begin
				always @*
					if (srmux)
						q <= regset;
					else if (~clk & ce)
						q <= d;
			end
			else
			begin
				always @*
					if (~clk) begin
						if (srmux)
							q <= regset;
						else if (ce)
							q <= d;
					end
			end
		end
    endgenerate
endmodule