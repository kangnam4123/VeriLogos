module ActionReplay
(
	input	clk,
	input	reset,
	input	[23:1] cpu_address,
	input	[23:1] cpu_address_in,
	input	cpu_clk,
	input	_cpu_as,
	input	[8:1] reg_address_in,
	input	[15:0] reg_data_in,
	input	[15:0] data_in,
	output	[15:0] data_out,
	input	cpu_rd,
	input	cpu_hwr,
	input	cpu_lwr,
	input	dbr,
	output	ovr,
	input	freeze,
	output	reg int7,
	output	selmem,
	output	reg aron = 1'b0
);
reg		freeze_del;
wire	freeze_req;
wire	int7_req;
wire	int7_ack;
reg		l_int7_req;
reg		l_int7_ack;
reg		l_int7;
wire	reset_req;
wire	break_req;
reg		after_reset;
reg		[1:0] mode;
reg		[1:0] status;
reg		ram_ovl;	
reg		active;		
wire	sel_cart;	
wire	sel_rom;	
wire	sel_ram;	
wire 	sel_custom;	
wire	sel_status;	
wire	sel_mode;	
wire  sel_ovl;
wire	[15:0] custom_out;
wire	[15:0] status_out;
assign sel_cart = aron & ~dbr & (cpu_address_in[23:19]==5'b0100_0);
assign sel_rom = sel_cart & ~cpu_address_in[18] & |cpu_address_in[17:2];
assign sel_ram = sel_cart & cpu_address_in[18] & (cpu_address_in[17:9]!=9'b001111_000);
assign sel_custom = sel_cart & cpu_address_in[18] & (cpu_address_in[17:9]==9'b001111_000) & cpu_rd;
assign sel_mode = sel_cart & ~|cpu_address_in[18:1];
assign sel_status = sel_cart & ~|cpu_address_in[18:2] & cpu_rd;
assign sel_ovl = ram_ovl & (cpu_address_in[23:19]==5'b0000_0) & cpu_rd;
assign selmem = ((sel_rom & cpu_rd) | sel_ram | sel_ovl);
always @(negedge clk)
	if (!reset && cpu_address_in[23:18]==6'b0100_00 && cpu_lwr)
		aron <= 1'b1;	
always @(posedge clk)
	freeze_del <= freeze;
assign freeze_req = freeze & ~freeze_del & (~active);
assign int7_req =  (freeze_req | reset_req | break_req);
assign int7_ack = &cpu_address & ~_cpu_as;
always @(posedge cpu_clk)
	if (reset)
		int7 <= 1'b0;
	else if (int7_req)
		int7 <= 1'b1;
	else if (int7_ack)
		int7 <= 1'b0;
always @(posedge clk)
	l_int7_req <= int7_req;
always @(posedge clk)
	l_int7_ack <= int7_ack;
always @(posedge clk)
	if (reset)
		l_int7 <= 1'b0;
	else if (l_int7_req)
		l_int7 <= 1'b1;
	else if (l_int7_ack && cpu_rd)
		l_int7 <= 1'b0;
assign reset_req = aron && cpu_address[23:1]==23'h04 && !_cpu_as && after_reset ? 1'b1 : 1'b0;
always @(posedge cpu_clk)
	if (reset)
		after_reset <= 1'b1;
	else if (int7_ack)
		after_reset <= 1'b0;
always @(posedge clk)
	if (reset)
		ram_ovl <= 1'b0;
	else if (aron && l_int7 && l_int7_ack && cpu_rd) 
		ram_ovl <= 1'b1;
	else if (sel_rom && (cpu_address_in[2:1]==2'b11) && (cpu_hwr|cpu_lwr))
		ram_ovl <= 1'b0;
always @(posedge clk)
	if (reset)
		active <= 1'b0;
	else if (aron && l_int7 && l_int7_ack && cpu_rd)
		active <= 1'b1;
	else if (sel_mode && (cpu_address_in[2:1]==2'b00) && (cpu_hwr|cpu_lwr))
		active <= 1'b0;
assign ovr = ram_ovl;
always @(posedge clk)
	if (reset)
		mode <= 2'b11;
	else if (sel_mode && cpu_lwr)	
		mode <= data_in[1:0];
always @(posedge clk)
	if (reset)
		status <= 2'b11;
	else if (freeze_req)			
		status <= 2'b00;
	else if (break_req)			
		status <= 2'b01;
assign status_out = sel_status ? {14'h00,status} : 16'h00_00;
reg		[15:0] custom [255:0];
reg		[8:1] custom_adr;
always @(negedge clk)
	custom_adr[8:1] <= cpu_address_in[8:1];
always @(posedge clk)
	custom[reg_address_in] <= reg_data_in;
assign custom_out = sel_custom ? custom[custom_adr[8:1]] : 16'h00_00;
assign data_out = custom_out | status_out;
reg	cpu_address_hit;
always @(posedge _cpu_as)
	cpu_address_hit <= cpu_address[23:10]==14'h00 ? 1'b1 : 1'b0;
assign break_req = ~active && aron && mode[1] && cpu_address_hit && cpu_address==(24'hBFE001>>1) && !_cpu_as ? 1'b1 : 1'b0;
endmodule