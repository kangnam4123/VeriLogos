module paula_intcontroller
(
	input 	clk,		    	
  input clk7_en,
	input 	reset,			   	
	input 	[8:1] reg_address_in,	
	input	[15:0] data_in,		
	output	[15:0] data_out,		
	input	rxint,				
	input	txint,				
  input vblint,         
	input	int2,				
	input	int3,				
	input	int6,				
	input	blckint,			
	input	syncint,			
	input	[3:0] audint,		
	output	[3:0] audpen,		
	output	rbfmirror,			
	output	reg [2:0] _ipl		
);
parameter INTENAR = 9'h01c;
parameter INTREQR = 9'h01e;
parameter INTENA  = 9'h09a;
parameter INTREQ  = 9'h09c;
reg		[14:0] intena;			
reg 	[15:0] intenar;			
reg		[14:0] intreq;			
reg		[15:0] intreqr;			
assign rbfmirror = intreq[11];
assign audpen[3:0] = intreq[10:7];
assign data_out = intenar | intreqr;
always @(posedge clk) begin
  if (clk7_en) begin
  	if (reset)
  		intena <= 0;
  	else if (reg_address_in[8:1]==INTENA[8:1])
  	begin
  		if (data_in[15])
  			intena[14:0] <= intena[14:0] | data_in[14:0];
  		else
  			intena[14:0] <= intena[14:0] & (~data_in[14:0]);	
  	end
  end
end
always @(*) begin
	if (reg_address_in[8:1]==INTENAR[8:1])
		intenar[15:0] = {1'b0,intena[14:0]};
	else
		intenar = 16'd0;
end
always @(*) begin
	if (reg_address_in[8:1]==INTREQR[8:1])
		intreqr[15:0] = {1'b0,intreq[14:0]};
	else
		intreqr = 16'd0;
end
reg [14:0]tmp;
always @(*) begin
	if (reg_address_in[8:1]==INTREQ[8:1])
	begin
		if (data_in[15])
			tmp[14:0] = intreq[14:0] | data_in[14:0];
		else
			tmp[14:0] = intreq[14:0] & (~data_in[14:0]);	
 	end
	else
		tmp[14:0] = intreq[14:0];
end
always @(posedge clk) begin
  if (clk7_en) begin
	  if (reset)
	  	intreq <= 0;
	  else 
	  begin
	  	intreq[0] <= tmp[0] | txint;
	  	intreq[1] <= tmp[1] | blckint;
	  	intreq[2] <= tmp[2];
	  	intreq[3] <= tmp[3] | int2;
	  	intreq[4] <= tmp[4];
	  	intreq[5] <= tmp[5] | vblint;
	  	intreq[6] <= tmp[6] | int3;
	  	intreq[7] <= tmp[7] | audint[0];
	  	intreq[8] <= tmp[8] | audint[1];
	  	intreq[9] <= tmp[9] | audint[2];
	  	intreq[10] <= tmp[10] | audint[3];
	  	intreq[11] <= tmp[11] | rxint;
	  	intreq[12] <= tmp[12] | syncint;
	  	intreq[13] <= tmp[13] | int6;
	  	intreq[14] <= tmp[14];
	  end
  end
end						  
reg	[14:0]intreqena;
always @(*) begin
	if (intena[14])
		intreqena[14:0] = intreq[14:0] & intena[14:0];
	else
		intreqena[14:0] = 15'b000_0000_0000_0000;	
end
always @(posedge clk) begin
  if (clk7_en) begin
	  casez (intreqena[14:0])
	  	15'b1?????????????? : _ipl <= 1;
	  	15'b01????????????? : _ipl <= 1;
	  	15'b001???????????? : _ipl <= 2;
	  	15'b0001??????????? : _ipl <= 2;
	  	15'b00001?????????? : _ipl <= 3;
	  	15'b000001????????? : _ipl <= 3;
	  	15'b0000001???????? : _ipl <= 3;
	  	15'b00000001??????? : _ipl <= 3;
	  	15'b000000001?????? : _ipl <= 4;
	  	15'b0000000001????? : _ipl <= 4;
	  	15'b00000000001???? : _ipl <= 4;
	  	15'b000000000001??? : _ipl <= 5;
	  	15'b0000000000001?? : _ipl <= 6;
	  	15'b00000000000001? : _ipl <= 6;
	  	15'b000000000000001 : _ipl <= 6;
	  	15'b000000000000000 : _ipl <= 7;
	  	default:			  _ipl <= 7;
	  endcase
  end
end
endmodule