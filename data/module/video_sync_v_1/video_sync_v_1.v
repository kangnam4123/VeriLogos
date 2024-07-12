module video_sync_v_1(
	input  wire        clk,
	input  wire        hsync_start, 
	input  wire        line_start,  
	input  wire        hint_start,
	input  wire        mode_atm_n_pent,
	input  wire [ 1:0] modes_raster,
	output reg         vblank,
	output reg         vsync,
	output reg         int_start, 
	output reg         vpix 
);
	localparam VBLNK_BEG = 9'd00;
	localparam VSYNC_BEG_50HZ = 9'd08;
	localparam VSYNC_END_50HZ = 9'd11;
	localparam VBLNK_END_50HZ = 9'd32;
	localparam VSYNC_BEG_60HZ = 9'd04;
	localparam VSYNC_END_60HZ = 9'd07;
	localparam VBLNK_END_60HZ = 9'd22;
	localparam VPIX_BEG_PENTAGON = 9'd076; 
	localparam VPIX_END_PENTAGON = 9'd272; 
	localparam VPIX_BEG_60HZ     = 9'd042;
	localparam VPIX_END_60HZ     = 9'd238;
	localparam VPIX_BEG_48K      = 9'd060;
	localparam VPIX_END_48K      = 9'd256;
	localparam VPIX_BEG_128K     = 9'd059;
	localparam VPIX_END_128K     = 9'd255;
	localparam VPERIOD_PENTAGON = 9'd320;
	localparam VPERIOD_60HZ     = 9'd262;
	localparam VPERIOD_48K      = 9'd312;
	localparam VPERIOD_128K     = 9'd311;
	localparam INT_BEG      = 9'd0;
	localparam INT_BEG_48K  = 9'd1;
	localparam INT_BEG_128K = 9'd1;
	reg [8:0] vcount;
	reg [8:0] vperiod;
	reg [8:0] vpix_beg;
	reg [8:0] vpix_end;
	initial 
	begin
		vcount = 9'd0;
		vsync = 1'b0;
		vblank = 1'b0;
		vpix = 1'b0;
		int_start = 1'b0;
		vperiod = 'd0;
		vpix_beg = 'd0;
		vpix_end = 'd0;
	end
	always @(posedge clk)
	case( modes_raster )
		default: vperiod <= VPERIOD_PENTAGON - 9'd1;
		2'b01:   vperiod <= VPERIOD_60HZ     - 9'd1;
		2'b10:   vperiod <= VPERIOD_48K      - 9'd1;
		2'b11:   vperiod <= VPERIOD_128K     - 9'd1;
	endcase
	always @(posedge clk)
	case( modes_raster )
		default: vpix_beg <= VPIX_BEG_PENTAGON;
		2'b01:   vpix_beg <= VPIX_BEG_60HZ    ;
		2'b10:   vpix_beg <= VPIX_BEG_48K     ;
		2'b11:   vpix_beg <= VPIX_BEG_128K    ;
	endcase
	always @(posedge clk)
	case( modes_raster )
		default: vpix_end <= VPIX_END_PENTAGON;
		2'b01:   vpix_end <= VPIX_END_60HZ    ;
		2'b10:   vpix_end <= VPIX_END_48K     ;
		2'b11:   vpix_end <= VPIX_END_128K    ;
	endcase
	always @(posedge clk) if( hsync_start )
	begin
		if( vcount==vperiod )
		begin
			vcount <= 9'd0;
		end
		else
			vcount <= vcount + 9'd1;
	end
	always @(posedge clk) if( hsync_start )
	begin
		if( vcount==VBLNK_BEG )
			vblank <= 1'b1;
		else if( vcount==( (modes_raster==2'b01) ? VBLNK_END_60HZ : VBLNK_END_50HZ ) )
			vblank <= 1'b0;
	end
	always @(posedge clk)
	begin
		if( vcount==( modes_raster==2'b01 ? VSYNC_BEG_60HZ : VSYNC_BEG_50HZ ) && hsync_start )
			vsync <= 1'b1;
		else if( vcount==( modes_raster==2'b01 ? VSYNC_END_60HZ : VSYNC_END_50HZ ) && line_start  )
			vsync <= 1'b0;
	end
	always @(posedge clk)
	begin
		if( hint_start && vcount==( modes_raster[1] ? (modes_raster[0] ? INT_BEG_128K : INT_BEG_48K) : INT_BEG ) )
			int_start <= 1'b1;
		else
			int_start <= 1'b0;
	end
	always @(posedge clk) if( hsync_start )
	begin
		if( vcount==(vpix_beg + (9'd4 & {9{~mode_atm_n_pent}})) )
			vpix <= 1'b1;
		else if( vcount==(vpix_end + (9'd4 & {9{mode_atm_n_pent}})) )
			vpix <= 1'b0;
	end
endmodule