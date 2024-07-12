module video_sync_h(
	input  wire        clk,
	input  wire        init, 
	input  wire        cend,     
	input  wire        pre_cend,
	input  wire        mode_atm_n_pent,
	input  wire        mode_a_text,
	output reg         hblank,
	output reg         hsync,
	output reg         line_start,  
	output reg         hsync_start, 
	output reg         hint_start, 
	output reg         scanin_start,
	output reg         hpix, 
	output reg         fetch_start, 
	output reg         fetch_end    
);
	localparam HBLNK_BEG = 9'd00;
	localparam HSYNC_BEG = 9'd10;
	localparam HSYNC_END = 9'd43;
	localparam HBLNK_END = 9'd88;
	localparam HPIX_BEG_PENT = 9'd140; 
	localparam HPIX_END_PENT = 9'd396;
	localparam HPIX_BEG_ATM = 9'd108; 
	localparam HPIX_END_ATM = 9'd428;
	localparam FETCH_FOREGO = 9'd18; 
	localparam SCANIN_BEG = 9'd88; 
	localparam HINT_BEG = 9'd2;
	localparam HPERIOD = 9'd448;
	reg [8:0] hcount;
	initial
	begin
		hcount = 9'd0;
		hblank = 1'b0;
		hsync = 1'b0;
		line_start = 1'b0;
		hsync_start = 1'b0;
		hpix = 1'b0;
	end
	always @(posedge clk) if( cend )
	begin
            if( init || (hcount==(HPERIOD-9'd1)) )
            	hcount <= 9'd0;
            else
            	hcount <= hcount + 9'd1;
	end
	always @(posedge clk) if( cend )
	begin
		if( hcount==HBLNK_BEG )
			hblank <= 1'b1;
		else if( hcount==HBLNK_END )
			hblank <= 1'b0;
		if( hcount==HSYNC_BEG )
			hsync <= 1'b1;
		else if( hcount==HSYNC_END )
			hsync <= 1'b0;
	end
	always @(posedge clk)
	begin
		if( pre_cend )
		begin
			if( hcount==HSYNC_BEG )
				hsync_start <= 1'b1;
			if( hcount==HBLNK_END )
				line_start <= 1'b1;
			if( hcount==SCANIN_BEG )
				scanin_start <= 1'b1;
		end
		else
		begin
			hsync_start  <= 1'b0;
			line_start   <= 1'b0;
			scanin_start <= 1'b0;
		end
	end
	wire fetch_start_time, fetch_start_condition;
	wire fetch_end_condition;
	reg [3:0] fetch_start_wait;
	assign fetch_start_time = (mode_atm_n_pent                  ?
	                          (HPIX_BEG_ATM -FETCH_FOREGO-9'd4) :
	                          (HPIX_BEG_PENT-FETCH_FOREGO-9'd4) ) == hcount;
	always @(posedge clk) if( cend )
		fetch_start_wait[3:0] <= { fetch_start_wait[2:0], fetch_start_time };
	assign fetch_start_condition = mode_a_text ? fetch_start_time  : fetch_start_wait[3];
	always @(posedge clk)
	if( pre_cend && fetch_start_condition )
		fetch_start <= 1'b1;
	else
		fetch_start <= 1'b0;
	assign fetch_end_time = (mode_atm_n_pent             ?
	                        (HPIX_END_ATM -FETCH_FOREGO) :
	                        (HPIX_END_PENT-FETCH_FOREGO) ) == hcount;
	always @(posedge clk)
	if( pre_cend && fetch_end_time )
		fetch_end <= 1'b1;
	else
		fetch_end <= 1'b0;
	always @(posedge clk)
	begin
		if( pre_cend && (hcount==HINT_BEG) )
			hint_start <= 1'b1;
		else
			hint_start <= 1'b0;
	end
	always @(posedge clk) if( cend )
	begin
		if( hcount==(mode_atm_n_pent ? HPIX_BEG_ATM : HPIX_BEG_PENT) )
			hpix <= 1'b1;
		else if( hcount==(mode_atm_n_pent ? HPIX_END_ATM : HPIX_END_PENT) )
			hpix <= 1'b0;
	end
endmodule