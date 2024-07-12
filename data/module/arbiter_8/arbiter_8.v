module arbiter_8(
	input clk,
	input rst_n,
	output     [20:0] dram_addr,   
	output reg        dram_req,    
	output reg        dram_rnw,    
	input             dram_cbeg,   
	input             dram_rrdy,   
	output      [1:0] dram_bsel,   
	input      [15:0] dram_rddata, 
	output     [15:0] dram_wrdata, 
	output reg cend,      
	output reg pre_cend,  
	output reg post_cbeg, 
	input go, 
	input [1:0] bw, 
	input  [20:0] video_addr,   
	output [15:0] video_data,   
	output reg    video_strobe, 
	output reg    video_next,   
	input  wire        cpu_req,
	input  wire        cpu_rnw,
	input  wire [20:0] cpu_addr,
	input  wire [ 7:0] cpu_wrdata,
	input  wire        cpu_wrbsel,
	output wire [15:0] cpu_rddata,
	output reg         cpu_next,
        output reg         cpu_strobe
);
	wire cbeg;
	reg [1:0] cctr; 
	reg stall;
	reg cpu_rnw_r;
	reg [2:0] blk_rem;  
	reg [2:0] blk_nrem; 
	reg [2:0] vid_rem;  
	reg [2:0] vid_nrem; 
	wire [2:0] vidmax; 
	localparam CYC_VIDEO = 2'b00; 
	localparam CYC_CPU   = 2'b01; 
	localparam CYC_FREE  = 2'b10; 
	reg [1:0] curr_cycle; 
	reg [1:0] next_cycle; 
	initial 
	begin
		curr_cycle = CYC_FREE;
		blk_rem = 0;
		vid_rem = 0;
	end
	assign cbeg = dram_cbeg; 
	always @(posedge clk)
	begin
		post_cbeg <= cbeg;
		pre_cend  <= post_cbeg;
		cend      <= pre_cend;
	end
	always @(posedge clk) if( cend )
	begin
		blk_rem <= blk_nrem;
		if( (blk_rem==3'd0) )
			stall <= (bw==2'd3) & go;
	end
	always @*
	begin
		if( (blk_rem==3'd0) && go )
			blk_nrem = 7;
		else
			blk_nrem = (blk_rem==0) ? 3'd0 : (blk_rem-3'd1);
	end
	assign vidmax = (3'b001) << bw; 
	always @(posedge clk) if( cend )
	begin
		vid_rem <= vid_nrem;
	end
	always @*
	begin
		if( go && (blk_rem==3'd0) )
			vid_nrem = cpu_req ? vidmax : (vidmax-3'd1);
		else
			if( next_cycle==CYC_VIDEO )
				vid_nrem = (vid_rem==3'd0) ? 3'd0 : (vid_rem-3'd1);
			else
				vid_nrem = vid_rem;
	end
	always @*
	begin
		if( blk_rem==3'd0 )
		begin
			if( go )
			begin
				if( bw==2'b11 )
				begin
					cpu_next = 1'b0;
					next_cycle = CYC_VIDEO;
				end
				else
				begin
					cpu_next = 1'b1;
					if( cpu_req )
						next_cycle = CYC_CPU;
					else
						next_cycle = CYC_VIDEO;
				end
			end
			else 
			begin
				cpu_next = 1'b1;
				if( cpu_req )
					next_cycle = CYC_CPU;
				else
					next_cycle = CYC_FREE;
			end
		end
		else 
		begin
			if( stall )
			begin
				cpu_next = 1'b0;
				next_cycle = CYC_VIDEO;
			end
			else
			begin
				if( vid_rem==blk_rem )
				begin
					cpu_next = 1'b0;
					next_cycle = CYC_VIDEO;
				end
				else
				begin
					cpu_next = 1'b1;
					if( cpu_req )
						next_cycle = CYC_CPU;
					else
						if( vid_rem==3'd0 )
							next_cycle = CYC_FREE;
						else
							next_cycle = CYC_VIDEO;
				end
			end
		end
	end
	always @(posedge clk) if( cend )
	begin
		curr_cycle <= next_cycle;
	end
	assign dram_wrdata[15:0] = { cpu_wrdata[7:0], cpu_wrdata[7:0] };
	assign dram_bsel[1:0] = { ~cpu_wrbsel, cpu_wrbsel };
	assign dram_addr = next_cycle[0] ? cpu_addr : video_addr;
	assign cpu_rddata = dram_rddata;
	assign video_data = dram_rddata;
	always @*
	begin
		if( next_cycle[1] ) 
		begin
			dram_req = 1'b0;
			dram_rnw = 1'b1;
		end
		else 
		begin
			dram_req = 1'b1;
			if( next_cycle[0] ) 
				dram_rnw = cpu_rnw;
			else 
				dram_rnw = 1'b1;
		end
	end
	always @(posedge clk)
	if( cend )
		cpu_rnw_r <= cpu_rnw;
	always @(posedge clk)
	begin
		if( (curr_cycle==CYC_CPU) && cpu_rnw_r && pre_cend )
			cpu_strobe <= 1'b1;
		else
			cpu_strobe <= 1'b0;
	end
	always @(posedge clk)
	begin
		if( (curr_cycle==CYC_VIDEO) && pre_cend )
			video_strobe <= 1'b1;
		else
			video_strobe <= 1'b0;
		if( (curr_cycle==CYC_VIDEO) && post_cbeg )
			video_next <= 1'b1;
		else
			video_next <= 1'b0;
	end
endmodule