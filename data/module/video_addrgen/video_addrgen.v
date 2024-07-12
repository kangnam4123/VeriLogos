module video_addrgen(
	input  wire        clk, 
	output reg  [20:0] video_addr, 
	input  wire        video_next, 
	input  wire        line_start, 
	input  wire        int_start,  
	input  wire        vpix,       
	input  wire        scr_page, 
	input  wire        mode_atm_n_pent, 
	input  wire        mode_zx,         
	input  wire        mode_p_16c,      
	input  wire        mode_p_hmclr,    
	input  wire        mode_a_hmclr,    
	input  wire        mode_a_16c,      
	input  wire        mode_a_text,     
	input  wire        mode_a_txt_1page,
	output wire [ 2:0] typos 
);
	wire mode_ag;
	assign mode_ag = mode_a_16c | mode_a_hmclr;
	wire line_init, frame_init;
	wire gnext,tnext,ldaddr;
	reg line_start_r;
	reg frame_init_r;
	reg line_init_r;
	always @(posedge clk)
		line_start_r <= line_start;
	assign line_init  = line_start_r & vpix;
	assign frame_init = int_start;
	reg [13:0] gctr;
	reg [7:0] tyctr; 
	reg [6:0] txctr; 
	reg not_used;
	always @(posedge clk)
		frame_init_r <= frame_init;
	always @(posedge clk)
		line_init_r <= line_init;
	assign gnext = video_next | frame_init_r;
	assign tnext = video_next | line_init_r;
	assign ldaddr = mode_a_text ? tnext : gnext;
	initial gctr <= 0;
	always @(posedge clk)
	if( frame_init )
		gctr <= 0;
	else if( gnext )
		gctr <= gctr + 1;
	always @(posedge clk)
	if( frame_init )
		tyctr <= 8'b0011_0111;
	else if( line_init )
		tyctr <= tyctr + 1;
	always @(posedge clk)
	if( line_init )
		txctr <= 7'b000_0000;
	else if( tnext )
		txctr <= txctr + 1;
	assign typos = tyctr[2:0];
	wire [20:0] addr_zx;   
	wire [20:0] addr_phm;  
	wire [20:0] addr_p16c; 
	wire [20:0] addr_ag; 
	wire [20:0] addr_at; 
	wire [11:0] addr_zx_pix;
	wire [11:0] addr_zx_attr;
	wire [11:0] addr_zx_p16c;
	assign addr_zx_pix  = { gctr[12:11], gctr[7:5], gctr[10:8], gctr[4:1] };
	assign addr_zx_attr = { 3'b110, gctr[12:8], gctr[4:1] };
	assign addr_zx_p16c = { gctr[13:12], gctr[8:6], gctr[11:9], gctr[5:2] };
	assign addr_zx =   { 6'b000001, scr_page, 2'b10, ( gctr[0] ? addr_zx_attr : addr_zx_pix ) };
	assign addr_phm =  { 6'b000001, scr_page, 1'b1, gctr[0], addr_zx_pix };
	assign addr_p16c = { 6'b000001, scr_page, ~gctr[0], gctr[1], addr_zx_p16c };
	assign addr_ag = { 5'b00000, ~gctr[0], scr_page, 1'b1, gctr[1], gctr[13:2] };
	assign addr_at = { 4'b0000,
	                   mode_a_txt_1page, 
	                   mode_a_txt_1page ? 1'b0 : ~txctr[0], 
	                   scr_page,         
	                   ~mode_a_txt_1page, 
	                   mode_a_txt_1page ? txctr[0] : txctr[1], 
	                   mode_a_txt_1page ? txctr[1] : 1'b0, 
	                   1'b0,
	                   tyctr[7:3],
	                   txctr[6:2]
	                   };
	initial video_addr <= 0;
	always @(posedge clk) if( ldaddr )
	begin
		{ video_addr[20:15], not_used, video_addr[13:0] } <=
			( {21{mode_zx     }} & addr_zx  )  |
			( {21{mode_p_16c  }} & addr_p16c)  |
			( {21{mode_p_hmclr}} & addr_phm )  |
			( {21{mode_ag     }} & addr_ag  )  |
			( {21{mode_a_text }} & addr_at  )  ;
	end
	always @(posedge clk)
		video_addr[14] <= scr_page;
endmodule