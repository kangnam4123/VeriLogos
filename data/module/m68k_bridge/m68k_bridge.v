module m68k_bridge
(
	input	clk28m,					
  input blk,
	input	c1,						
	input	c3,						
	input	clk,					
  input cpu_clk,        
	input	[9:0] eclk,				
	input	vpa,					
	input	dbr, 					
	input	dbs,					
	input	xbs,					
  input nrdy,         
	output	bls,					
	input	cck,					
	input	cpu_speed,				
  input [3:0] memory_config,  
	output	reg turbo,				
	input	_as,					
	input	_lds,					
	input	_uds,					
	input	r_w,					
	output	 _dtack,				
	output	rd,						
	output	hwr,					
	output	lwr,					
	input	[23:1] address,			
	output	[23:1] address_out,	
  output  [15:0] data,      
  input [15:0] cpudatain,
  output  [15:0] data_out,  
  input [15:0] data_in,      
  input _cpu_reset,
  input cpu_halt,
  input host_cs,
  input [23:1] host_adr,
  input host_we,
  input [1:0] host_bs,
  input [15:0] host_wdat,
  output [15:0] host_rdat,
  output host_ack
);
localparam VCC = 1'b1;
localparam GND = 1'b0;
wire	doe;					
reg		[15:0] ldata_in;		
wire	enable;					
reg		lr_w,l_as,l_dtack;  	
reg		l_uds,l_lds;
reg		lvpa;					
reg		vma;					
reg		_ta;					
reg halt=0;
always @ (posedge clk) begin
   if (_as && cpu_halt)
    halt <= #1 1'b1;
  else if (_as && !cpu_halt)
    halt <= #1 1'b0;
end
always @(posedge clk)
	if (_as)
		turbo <= cpu_speed;
wire  turbo_cpu;
assign turbo_cpu = 1'b0;
always @(posedge clk)
	lvpa <= vpa;
always @(posedge clk)
	if (eclk[9])
		vma <= 0;
	else if (eclk[3] && lvpa)
		vma <= 1;
always @ (posedge clk) begin
  lr_w <= !halt ? r_w : !host_we;
  l_as <= !halt ? _as : !host_cs;
  l_dtack <= _dtack;
end
always @(posedge clk28m) begin
  l_uds <= !halt ? _uds : !(host_bs[1]);
  l_lds <= !halt ? _lds : !(host_bs[0]);
end
reg _as28m;
always @(posedge clk28m)
  _as28m <= !halt ? _as : !host_cs;
reg l_as28m;
always @(posedge clk)
  l_as28m <= _as28m;
wire _as_and_cs;
assign _as_and_cs = !halt ? _as : !host_cs;
reg _ta_n;
always @(negedge clk or posedge _as_and_cs)
  if (_as_and_cs)
    _ta_n <= VCC;
  else if (!l_as && cck && ((!vpa && !(dbr && dbs)) || (vpa && vma && eclk[8])) && !nrdy)
    _ta_n <= GND; 
assign host_ack = !_ta_n;
assign _dtack = (_ta_n );
assign enable = ((~l_as & ~l_dtack & ~cck & ~turbo) | (~l_as28m & l_dtack & ~(dbr & xbs) & ~nrdy & turbo));
assign rd = (enable & lr_w);
assign hwr = (enable & ~lr_w & ~l_uds);
assign lwr = (enable & ~lr_w & ~l_lds);
assign bls = dbs & ~l_as & l_dtack;
assign doe = r_w & ~_as;
assign data_out = !halt ? cpudatain : host_wdat;
always @(posedge clk28m)
  if (!c1 && c3 && enable)
    ldata_in <= data_in;
assign data[15:0] = ldata_in;
assign host_rdat = ldata_in;
assign 	address_out[23:1] = !halt ? address[23:1] : host_adr[23:1];
endmodule