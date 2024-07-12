module auddma_engine
(
	input 	clk,		    			
	output	dma,						
	input	[3:0] audio_dmal,			
	input	[3:0] audio_dmas,			
	input	[8:0] hpos,					
	input 	[8:1] reg_address_in,		
	output 	reg [8:1] reg_address_out,	
	input	[15:0] data_in,				
	output	[20:1] address_out			
);
parameter AUD0DAT = 9'h0AA;
parameter AUD1DAT = 9'h0BA;
parameter AUD2DAT = 9'h0CA;
parameter AUD3DAT = 9'h0DA;
wire	audlcena;				
wire	[1:0] audlcsel;			
reg		[20:16] audlch [3:0];	
reg		[15:1] audlcl [3:0];	
wire	[20:1] audlcout;		
reg		[20:1] audpt [3:0];		
wire	[20:1] audptout;		
reg		[1:0]  channel;			
reg		dmal;
reg		dmas;
assign audlcena = ~reg_address_in[8] & reg_address_in[7] & (reg_address_in[6]^reg_address_in[5]) & ~reg_address_in[3] & ~reg_address_in[2];
assign audlcsel = {~reg_address_in[5],reg_address_in[4]};
always @(posedge clk)
	if (audlcena & ~reg_address_in[1]) 
		audlch[audlcsel] <= data_in[4:0];
always @(posedge clk)
	if (audlcena & reg_address_in[1]) 
		audlcl[audlcsel] <= data_in[15:1];
assign audlcout = {audlch[channel],audlcl[channel]};
always @(hpos or audio_dmal)
	case (hpos)
		9'b0001_0010_1 : dmal = audio_dmal[0]; 
		9'b0001_0100_1 : dmal = audio_dmal[1]; 
		9'b0001_0110_1 : dmal = audio_dmal[2]; 
		9'b0001_1000_1 : dmal = audio_dmal[3]; 
		default        : dmal = 0;
	endcase
assign dma = dmal;
always @(hpos or audio_dmas)
	case (hpos)
		9'b0001_0010_1 : dmas = audio_dmas[0]; 
		9'b0001_0100_1 : dmas = audio_dmas[1]; 
		9'b0001_0110_1 : dmas = audio_dmas[2]; 
		9'b0001_1000_1 : dmas = audio_dmas[3]; 
		default        : dmas = 0;
	endcase
always @(hpos)
	case (hpos[3:2])
		2'b01 : channel = 0; 
		2'b10 : channel = 1; 
		2'b11 : channel = 2; 
		2'b00 : channel = 3; 
	endcase
assign address_out[20:1] = audptout[20:1];
always @(posedge clk)
	if (dmal)
		audpt[channel] <= dmas ? audlcout[20:1] : audptout[20:1] + 1'b1;
assign audptout[20:1] = audpt[channel];
always @(channel)
	case (channel)
		0 : reg_address_out[8:1] = AUD0DAT[8:1];
		1 : reg_address_out[8:1] = AUD1DAT[8:1];
		2 : reg_address_out[8:1] = AUD2DAT[8:1];
		3 : reg_address_out[8:1] = AUD3DAT[8:1];
	endcase
endmodule