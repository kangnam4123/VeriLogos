module sprdma_engine
(
	input 	clk,		    			
	input	clk28m,						
	input	ecs,						
	output	reg reqdma,					
	input	ackdma,						
	input	[8:0] hpos,					
	input	[10:0] vpos,				
	input	vbl,						
	input	vblend,						
	input	[8:1] reg_address_in,		
	output 	reg [8:1] reg_address_out,	
	input	[15:0] data_in,				
	output	[20:1] address_out			
);
parameter SPRPTBASE     = 9'h120;		
parameter SPRPOSCTLBASE = 9'h140;		
reg 	[20:16] sprpth [7:0];		
reg 	[15:1]  sprptl [7:0];		
reg		[15:8]  sprpos [7:0];		
reg		[15:4]  sprctl [7:0];		
wire	[9:0] vstart;				
wire	[9:0] vstop;				
reg		[2:0] sprite;				
wire	[20:1] newptr;				
reg 	enable;						
reg		sprvstop;					
reg		sprdmastate;				
reg		dmastate_mem [7:0];			
wire	dmastate;					
reg		dmastate_in;				
reg		[2:0] sprsel;				
always @(posedge clk28m)
	if (sprsel[2]==hpos[0])		
		sprsel <= sprsel + 1'b1;
wire	[2:0] ptsel;			
wire	[2:0] pcsel;			
assign ptsel = (ackdma) ? sprite : reg_address_in[4:2];
assign pcsel = (ackdma) ? sprite : reg_address_in[5:3];
assign newptr = address_out[20:1] + 1'b1;
wire [20:16] sprpth_in;
assign sprpth_in = ackdma ? newptr[20:16] : data_in[4:0];
always @(posedge clk)
	if (ackdma || ((reg_address_in[8:5]==SPRPTBASE[8:5]) && !reg_address_in[1]))
		sprpth[ptsel] <= sprpth_in;
assign address_out[20:16] = sprpth[sprite];
wire [15:1]sprptl_in;
assign sprptl_in = ackdma ? newptr[15:1] : data_in[15:1];
always @(posedge clk)
	if (ackdma || ((reg_address_in[8:5]==SPRPTBASE[8:5]) && reg_address_in[1]))
		sprptl[ptsel] <= sprptl_in;
assign address_out[15:1] = sprptl[sprite];
always @(posedge clk)
	if ((reg_address_in[8:6]==SPRPOSCTLBASE[8:6]) && (reg_address_in[2:1]==2'b00))
		sprpos[pcsel] <= data_in[15:8];
assign vstart[7:0] = sprpos[sprsel];
always @(posedge clk)
	if ((reg_address_in[8:6]==SPRPOSCTLBASE[8:6]) && (reg_address_in[2:1]==2'b01))
		sprctl[pcsel] <= {data_in[15:8],data_in[6],data_in[5],data_in[2],data_in[1]};
assign {vstop[7:0],vstart[9],vstop[9],vstart[8],vstop[8]} = sprctl[sprsel];
always @(posedge clk28m)
	dmastate_mem[sprsel] <= dmastate_in;
assign dmastate = dmastate_mem[sprsel];
always @(vbl or vpos or vstop or vstart or dmastate or ecs)
	if (vbl || ({ecs&vstop[9],vstop[8:0]}==vpos[9:0]))
		dmastate_in = 0;
	else if ({ecs&vstart[9],vstart[8:0]}==vpos[9:0])
		dmastate_in = 1;
	else
		dmastate_in = dmastate;
always @(posedge clk28m)
	if (sprite==sprsel && hpos[2:1]==2'b01)
		sprdmastate <= dmastate;
always @(posedge clk28m)
	if (sprite==sprsel && hpos[2:1]==2'b01)
		if ({ecs&vstop[9],vstop[8:0]}==vpos[9:0])
			sprvstop <= 1'b1;
		else
			sprvstop <= 1'b0;
always @(posedge clk)
	if (hpos[8:1]==8'h18 && hpos[0])
		enable <= 1;
	else if (hpos[8:1]==8'h38 && hpos[0])
		enable <= 0;
always @(posedge clk)
	if (hpos[2:0]==3'b001)
		sprite[2:0] <= {hpos[5]^hpos[4],~hpos[4],hpos[3]};
always @(vpos or vbl or vblend or hpos or enable or sprite or sprvstop or sprdmastate)
	if (enable && hpos[1:0]==2'b01)
	begin
		if (vblend || (sprvstop && ~vbl))
		begin
			reqdma = 1;
			if (hpos[2])
				reg_address_out[8:1] = {SPRPOSCTLBASE[8:6],sprite,2'b00};	
			else
				reg_address_out[8:1] = {SPRPOSCTLBASE[8:6],sprite,2'b01};	
		end
		else if (sprdmastate)
		begin
			reqdma = 1;
			if (hpos[2])
				reg_address_out[8:1] = {SPRPOSCTLBASE[8:6],sprite,2'b10};	
			else
				reg_address_out[8:1] = {SPRPOSCTLBASE[8:6],sprite,2'b11};	
		end
		else
		begin
			reqdma = 0;
			reg_address_out[8:1] = 8'hFF;
		end
	end
	else
	begin
		reqdma = 0;
		reg_address_out[8:1] = 8'hFF;
	end
endmodule