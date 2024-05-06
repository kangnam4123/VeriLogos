module sasc_brg(clk, rst, div0, div1, sio_ce, sio_ce_x4);
input		clk;
input		rst;
input	[7:0]	div0, div1;
output		sio_ce, sio_ce_x4;
reg	[7:0]	ps;
reg		ps_clr;
reg	[7:0]	br_cnt;
reg		br_clr;
reg		sio_ce_x4_r;
reg	[1:0]	cnt;
reg		sio_ce, sio_ce_x4;
reg		sio_ce_r ;
reg		sio_ce_x4_t;
always @(posedge clk)
	if(!rst)	ps <= #1 8'h0;
	else
	if(ps_clr)	ps <= #1 8'h0;
	else		ps <= #1 ps + 8'h1;
always @(posedge clk)
	ps_clr <= #1 (ps == div0);	
always @(posedge clk)
	if(!rst)	br_cnt <= #1 8'h0;
	else
	if(br_clr)	br_cnt <= #1 8'h0;
	else
	if(ps_clr)	br_cnt <= #1 br_cnt + 8'h1;
always @(posedge clk)
	br_clr <= #1 (br_cnt == div1); 
always @(posedge clk)
	sio_ce_x4_r <= #1 br_clr;
always @(posedge clk)
	sio_ce_x4_t <= #1 !sio_ce_x4_r & br_clr;
always @(posedge clk)
	sio_ce_x4 <= #1 sio_ce_x4_t;
always @(posedge clk)
	if(!rst)			cnt <= #1 2'h0;
	else
	if(!sio_ce_x4_r & br_clr)	cnt <= #1 cnt + 2'h1;
always @(posedge clk)
	sio_ce_r <= #1 (cnt == 2'h0);
always @(posedge clk)
	sio_ce <= #1 !sio_ce_r & (cnt == 2'h0);
endmodule