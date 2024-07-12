module XC2CAndArray(zia_in, config_bits, pterm_out);
	input wire[39:0]			zia_in;
	input wire[80*56 - 1 : 0]	config_bits;
	output reg[55:0]			pterm_out;
	integer nterm;
	integer nrow;
	integer nin;
	reg[79:0] and_config[55:0];
	always @(*) begin
		for(nterm=0; nterm<56; nterm=nterm+1) begin
			for(nin=0; nin<80; nin=nin + 1)
				and_config[nterm][nin]		<= config_bits[nterm*80 + nin];
		end
	end
	always @(*) begin
		for(nterm=0; nterm<56; nterm = nterm+1) begin
			pterm_out[nterm] = 1;		
			for(nrow=0; nrow<40; nrow=nrow+1) begin
				if(!and_config[nterm][nrow*2])
					pterm_out[nterm] = pterm_out[nterm] & zia_in[nrow];
				if(!and_config[nterm][nrow*2 + 1])
					pterm_out[nterm] = pterm_out[nterm] & ~zia_in[nrow];
			end
		end
	end
endmodule