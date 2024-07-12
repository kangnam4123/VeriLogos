module chan_ctrl
(
	input  wire clk, 
	input  wire rst_n,
	output reg  [ 6:0] rd_addr,
	input  wire [31:0] rd_data,
	output reg  [ 6:0] wr_addr,
	output wire [31:0] wr_data,
	output reg         wr_stb,
	input  wire        sync_stb,
	input  wire [31:0] ch_enas,
	output reg  [ 7:0] out_data, 
	output reg         out_stb_addr, 
	output reg         out_stb_mix   
);
	reg [ 5:0] curr_ch; 
	wire       stop = curr_ch[5];
	reg [3:0] st;
	reg [3:0] next_st;
	wire ch_ena = ch_enas[curr_ch[4:0]];
	reg [31:0] offset;
	reg        off_cy; 
	reg oversize;
	reg [5:0] vol_left;
	reg [5:0] vol_right;
	reg loopena;
	reg surround;
	reg [21:0] base;
	reg [1:0] addr_emit;
	localparam ST_BEGIN     = 4'd0;
	localparam ST_GETOFFS   = 4'd1; 
	localparam ST_GETADDVOL = 4'd2; 
	localparam ST_GETSIZE   = 4'd3; 
	localparam ST_GETLOOP   = 4'd4; 
	localparam ST_SAVEOFFS  = 4'd5;
	localparam ST_NEXT = 4'd14;
	localparam ST_WAIT = 4'd15;
	always @(posedge clk)
	     if( st==ST_WAIT )
		curr_ch[5:0] <= 6'd0;
	else if( st==ST_NEXT )
		curr_ch[5:0] <= curr_ch[5:0] + 6'd1;
	always @(posedge clk, negedge rst_n)
	if( !rst_n )
		st <= ST_WAIT;
	else
		st <= next_st;
	always @*
	case( st )
	ST_BEGIN:
	if( stop )
		next_st = ST_WAIT;
	else if( !ch_ena )
		next_st = ST_NEXT;
	else
		next_st = ST_GETOFFS;
	ST_GETOFFS:
		next_st = ST_GETADDVOL;
	ST_GETADDVOL:
		next_st = ST_GETSIZE;
	ST_GETSIZE:
		next_st = ST_GETLOOP;
	ST_GETLOOP:
		next_st = ST_SAVEOFFS;
	ST_SAVEOFFS:
		next_st = ST_NEXT;
	ST_NEXT:
		next_st = ST_BEGIN;
	ST_WAIT:
	if( sync_stb )
		next_st = ST_BEGIN;
	else
		next_st = ST_WAIT;
	default: next_st = ST_WAIT;
	endcase
	always @*
		rd_addr[6:2] <= curr_ch[4:0];
	always @*
		wr_addr[6:2] <= curr_ch[4:0];
	always @(posedge clk)
		wr_addr[1:0] <= 2'd0;
	always @(posedge clk)
	if( st==ST_NEXT || st==ST_WAIT )
	begin
		rd_addr[1:0] <= 2'd0;
	end
	else if( st==ST_BEGIN || st==ST_GETOFFS || st==ST_GETADDVOL )
	begin
		rd_addr[1:0] <= rd_addr[1:0] + 2'd1;
	end
	always @(posedge clk)
	if( st==ST_GETOFFS )
		offset <= rd_data;
	else if( st==ST_GETADDVOL )
		{off_cy, offset} <= {1'b0, offset} + {1'b0, 14'd0, rd_data[31:14]};
	else if( st==ST_GETLOOP )
		offset[31:12] <= oversize ? (offset[31:12]+rd_data[27:8]) : offset[31:12]; 
	always @(posedge clk)
	if( st==ST_GETSIZE )
		oversize <= ( {off_cy,offset[31:12]} >= {1'b0, rd_data[27:8]} );
	always @(posedge clk)
		wr_stb <= st==ST_SAVEOFFS;
	assign wr_data = offset;
	always @(posedge clk)
	if( st==ST_GETADDVOL )
	begin
		vol_left  <= rd_data[11:6];
		vol_right <= rd_data[ 5:0];
		loopena  <= rd_data[13];
		surround <= rd_data[12];
	end
	always @(posedge clk)
	if( st==ST_GETSIZE )
		base[15:8] <= rd_data[7:0];
	else if( st==ST_GETLOOP )
		base[21:16] <= rd_data[5:0];
	else if( st==ST_SAVEOFFS )
	begin
		base[7:0] <= offset[19:12];
		base[21:8] <= base[21:8] + {2'd0,offset[31:20]};
	end
	always @(posedge clk, negedge rst_n)
	if( !rst_n )
		addr_emit <= 2'd0;
	else
		addr_emit[1:0] <= {addr_emit[0], st==ST_NEXT};
	always @(posedge clk)
	     if( st==ST_GETSIZE )
		out_data <= offset[11:4];
	else if( st==ST_GETLOOP )
		out_data <= {2'd0, vol_left[5:0]};
	else if( st==ST_SAVEOFFS )
		out_data <= {2'd0, vol_right[5:0] ^ {6{surround}}};
	else if( st==ST_NEXT )
		out_data <= {2'd0, base[21:16]};
	else if( addr_emit[0] )
		out_data <= base[15:8];
	else
		out_data <= base[7:0];
	always @(posedge clk, negedge rst_n)
	if( !rst_n )
		out_stb_mix <= 1'b0;
	else
		out_stb_mix <= (st==ST_GETSIZE)  ||
		               (st==ST_GETLOOP)  ||
		               (st==ST_SAVEOFFS) ;
	always @(posedge clk, negedge rst_n)
	if( !rst_n )
		out_stb_addr <= 1'b0;
	else
		out_stb_addr <= (st==ST_NEXT) || addr_emit;
endmodule