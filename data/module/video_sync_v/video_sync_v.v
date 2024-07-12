module video_sync_v(
	input  wire        clk,
	input  wire        hsync_start, 
	input  wire        line_start,  
	input  wire        hint_start,
	input  wire        mode_atm_n_pent,
	output reg         vblank,
	output reg         vsync,
	output reg         int_start, 
	output reg         vpix 
);
	localparam VBLNK_BEG = 9'd00;
	localparam VSYNC_BEG = 9'd08;
	localparam VSYNC_END = 9'd11;
	localparam VBLNK_END = 9'd32;
	localparam INT_BEG = 9'd0;
	localparam VPIX_BEG_PENT = 9'd080;
	localparam VPIX_END_PENT = 9'd272;
	localparam VPIX_BEG_ATM = 9'd076;
	localparam VPIX_END_ATM = 9'd276;
	localparam VPERIOD = 9'd320; 
	reg [8:0] vcount;
	initial
	begin
		vcount = 9'd0;
		vsync = 1'b0;
		vblank = 1'b0;
		vpix = 1'b0;
		int_start = 1'b0;
	end
	always @(posedge clk) if( hsync_start )
	begin
		if( vcount==(VPERIOD-9'd1) )
			vcount <= 9'd0;
		else
			vcount <= vcount + 9'd1;
	end
	always @(posedge clk) if( hsync_start )
	begin
		if( vcount==VBLNK_BEG )
			vblank <= 1'b1;
		else if( vcount==VBLNK_END )
			vblank <= 1'b0;
	end
	always @(posedge clk)
	begin
		if( (vcount==VSYNC_BEG) && hsync_start )
			vsync <= 1'b1;
		else if( (vcount==VSYNC_END) && line_start  )
			vsync <= 1'b0;
	end
	always @(posedge clk)
	begin
		if( (vcount==INT_BEG) && hint_start )
			int_start <= 1'b1;
		else
			int_start <= 1'b0;
	end
	always @(posedge clk) if( hsync_start )
	begin
		if( vcount==(mode_atm_n_pent ? VPIX_BEG_ATM : VPIX_BEG_PENT) )
			vpix <= 1'b1;
		else if( vcount==(mode_atm_n_pent ? VPIX_END_ATM : VPIX_END_PENT) )
			vpix <= 1'b0;
	end
endmodule