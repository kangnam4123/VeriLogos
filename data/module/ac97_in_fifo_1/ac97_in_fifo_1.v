module ac97_in_fifo_1(clk, rst, en, mode, din, we, dout, re, status, full, empty);
input		clk, rst;
input		en;
input	[1:0]	mode;
input	[19:0]	din;
input		we;
output	[31:0]	dout;
input		re;
output	[1:0]	status;
output		full;
output		empty;
reg	[31:0]	mem[0:7];
reg	[31:0]	dout;
reg	[4:0]	wp;
reg	[3:0]	rp;
wire	[4:0]	wp_p1;
reg	[1:0]	status;
reg	[15:0]	din_tmp1;
reg	[31:0]	din_tmp;
wire		m16b;
reg		full, empty;
assign m16b = (mode == 2'h0);	
always @(posedge clk)
	if(!en)		wp <= #1 5'h0;
	else
	if(we)		wp <= #1 wp_p1;
assign wp_p1 = m16b ? (wp + 5'h1) : (wp + 5'h2);
always @(posedge clk)
	if(!en)		rp <= #1 4'h0;
	else
	if(re)		rp <= #1 rp + 4'h1;
always @(posedge clk)
	status <= #1 ((rp[2:1] - wp[3:2]) - 2'h1);
always @(posedge clk)
	empty <= #1 (wp[4:1] == rp[3:0]) & (m16b ? !wp[0] : 1'b0);
always @(posedge clk)
	full  <= #1 (wp[3:1] == rp[2:0]) & (wp[4] != rp[3]);
always @(posedge clk)
	dout <= #1 mem[ rp[2:0] ];
always @(posedge clk)
	if(we & !wp[0])	din_tmp1 <= #1 din[19:4];
always @(mode or din_tmp1 or din)
	case(mode)	
	   2'h0: din_tmp = {din[19:4], din_tmp1};	
	   2'h1: din_tmp = {14'h0, din[19:2]};		
	   2'h2: din_tmp = {11'h0, din[19:0]};		
	endcase
always @(posedge clk)
	if(we & (!m16b | (m16b & wp[0]) ) )	mem[ wp[3:1] ] <= #1 din_tmp;
endmodule