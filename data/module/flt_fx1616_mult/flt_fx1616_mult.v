module flt_fx1616_mult
	(
	input	     	clk,
	input	     	rstn,
	input	[31:0]	fx,
	input	[31:0]	bfl,
	output	reg [31:0]	fl
	);
reg		sfx;		
reg	[31:0]	afx;		
reg	[5:0]	nom_shft_1;	
reg	[55:0]	mfl_1;		
reg	[55:0]	nmfl_1;		
reg		sfx_1;
reg		sbfl_1;
reg	[7:0]	efl_1;		
reg	[7:0]	ebfl_1;		
reg		sfl_1;		
reg		result0;
reg		result0_1;
always @* 
        begin
                if(fx[31]) begin
                                sfx = 1;
                                afx = ~fx + 1;
                end else begin
                                sfx = 0;
                                afx = fx;
                end
		if((fx==0) || (bfl[30:0]==0))result0 = 1;
		else result0 = 0;
        end
always @(posedge clk, negedge rstn) begin
	if(!rstn) begin
		mfl_1     <= 56'h0;
        	sfx_1     <= 1'b0;
		sbfl_1    <= 1'b0;
		ebfl_1    <= 8'h0;
		result0_1 <= 1'b0;
	end else begin
		mfl_1     <= afx * {1'b1,bfl[22:0]};
        	sfx_1     <= sfx;
		sbfl_1    <= bfl[31];
		ebfl_1    <= bfl[30:23];
		result0_1 <= result0;
	end
end
always @* begin
		casex(mfl_1[55:23]) 
		33'b1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd0;
		33'b01xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd1;
		33'b001xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd2;
		33'b0001xxxxxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd3;
		33'b00001xxxxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd4;
		33'b000001xxxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd5;
		33'b0000001xxxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd6;
		33'b00000001xxxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd7;
		33'b000000001xxxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd8;
		33'b0000000001xxxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd9;
		33'b00000000001xxxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd10;
		33'b000000000001xxxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd11;
		33'b0000000000001xxxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd12;
		33'b00000000000001xxxxxxxxxxxxxxxxxxx: nom_shft_1=6'd13;
		33'b000000000000001xxxxxxxxxxxxxxxxxx: nom_shft_1=6'd14;
		33'b0000000000000001xxxxxxxxxxxxxxxxx: nom_shft_1=6'd15;
		33'b00000000000000001xxxxxxxxxxxxxxxx: nom_shft_1=6'd16;
		33'b000000000000000001xxxxxxxxxxxxxxx: nom_shft_1=6'd17;
		33'b0000000000000000001xxxxxxxxxxxxxx: nom_shft_1=6'd18;
		33'b00000000000000000001xxxxxxxxxxxxx: nom_shft_1=6'd19;
		33'b000000000000000000001xxxxxxxxxxxx: nom_shft_1=6'd20;
		33'b0000000000000000000001xxxxxxxxxxx: nom_shft_1=6'd21;
		33'b00000000000000000000001xxxxxxxxxx: nom_shft_1=6'd22;
		33'b000000000000000000000001xxxxxxxxx: nom_shft_1=6'd23;
		33'b0000000000000000000000001xxxxxxxx: nom_shft_1=6'd24;
		33'b00000000000000000000000001xxxxxxx: nom_shft_1=6'd25;
		33'b000000000000000000000000001xxxxxx: nom_shft_1=6'd26;
		33'b0000000000000000000000000001xxxxx: nom_shft_1=6'd27;
		33'b00000000000000000000000000001xxxx: nom_shft_1=6'd28;
		33'b000000000000000000000000000001xxx: nom_shft_1=6'd29;
		33'b0000000000000000000000000000001xx: nom_shft_1=6'd30;
		33'b00000000000000000000000000000001x: nom_shft_1=6'd31;
		33'b000000000000000000000000000000001: nom_shft_1=6'd32;
		default: nom_shft_1=0;
		endcase
	end
always @* sfl_1 = sfx_1 ^ sbfl_1;
always @* efl_1 = ebfl_1 + (8'h10 - nom_shft_1);
always @* nmfl_1 = mfl_1 << nom_shft_1;
always @(posedge clk, negedge rstn)	
	begin
		if(!rstn) fl <= 32'h0;
		else if(result0_1) fl <= 32'h0;
		else fl <= {sfl_1,efl_1,nmfl_1[54:32]};
	end
endmodule