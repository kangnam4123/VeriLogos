module sram_ctl ( 
	input wire 			clk_i,
	input wire			reset_i,
	input wire [3:0]	A_i,
	input wire [7:0]	D_i,
	output wire [7:0]	D_o,
	input wire 			rd_i,
	input wire 			wr_i,
	output reg			wait_o,
	output reg			cpc_pause_o,
	input					cpc_pause_ack_i,
	input wire [23:0]	cpc_A_i,
	input wire [7:0]	cpc_D_i,
	output wire [7:0]	cpc_D_o,
	input wire	 		cpc_en_i,
	input wire	 		cpc_rd_i,
	input wire	 		cpc_wr_i,
	output wire [63:0] cpc_romflags_o,
	output wire [23:0]	mem_A_o,
	input wire [15:0]		mem_D_i,
	output wire [15:0]	mem_D_o,
	output wire	 			mem_go_o,
	output wire	[2:0]		mem_cmd_o,
	input wire				mem_busy_i,
	input wire				mem_valid_i
	);
	wire rd_rise, wr_rise, crd_rise, cwr_rise, busy_rise;
	wire [7:0] support_data_snip;
	reg [7:0]		A[0:3], DOUT = 8'd0;
	reg [1:0]		track_rd = 2'd0, track_wr = 2'd0, track_crd = 2'd0, track_cwr = 2'd0;
	reg 				control_ops = 1'd0;
	reg 				old_lsb = 1'b0, incr_address = 1'b0;
	reg [63:0]		romflags = 64'd0;
	assign mem_A_o = (cpc_pause_o & cpc_pause_ack_i) ? {1'b0, A[2], A[1], A[0][7:1]} : {1'b0,cpc_A_i[23:1]};		
	assign mem_D_o = (cpc_pause_o & cpc_pause_ack_i) ? {D_i,D_i} : {cpc_D_i,cpc_D_i};	
	assign mem_go_o = (cpc_pause_o & cpc_pause_ack_i) ? 											
									((rd_rise | wr_rise) & (A_i==4'd0)) : 
									((crd_rise | cwr_rise) & cpc_en_i);
	assign mem_cmd_o = (cpc_pause_o & cpc_pause_ack_i) ? {control_ops, rd_i, control_ops ? 1'b1 : A[0][0]} : {1'b0, cpc_rd_i, cpc_A_i[0]};
	assign cpc_D_o = cpc_A_i[0] ? mem_D_i[15:8] : mem_D_i[7:0];
	assign support_data_snip = (old_lsb ? mem_D_i[15:8] : mem_D_i[7:0]);
	assign D_o = (A_i == 4'd0) ? support_data_snip : DOUT;
	assign cpc_romflags_o = romflags;
	assign rd_rise = (track_rd == 2'b01);
	assign wr_rise = (track_wr == 2'b01);
	assign crd_rise = (track_crd == 2'b01);
	assign cwr_rise = (track_cwr == 2'b01);
	always @(posedge clk_i) track_rd <= {track_rd[0],rd_i};
	always @(posedge clk_i) track_wr <= {track_wr[0],wr_i};
	always @(posedge clk_i) track_crd <= {track_rd[0],cpc_rd_i};
	always @(posedge clk_i) track_cwr <= {track_wr[0],cpc_wr_i};
	always @(posedge clk_i or posedge reset_i)
	if( reset_i ) begin
		{A[3],A[2],A[1],A[0]} <= 32'd0;
		DOUT <= 8'd0;
		cpc_pause_o <= 1'b0;
		incr_address <= 1'b0;
		romflags <= 64'd0;
	end else begin
		if( (mem_valid_i | mem_busy_i) & incr_address ) begin	
			old_lsb <= A[0][0];
			{A[3],A[2],A[1],A[0]} <= {A[3],A[2],A[1],A[0]} + 1'b1;
			incr_address <= 1'b0;
		end
		else
		case( A_i )
			4'b0000 : begin
				if( rd_rise | wr_rise ) incr_address <= 1'b1;
			end
			4'b1000, 4'b1001, 4'b1010, 4'b1011 : begin
				if( rd_i ) DOUT <= A[A_i[1:0]];
				else
				if( wr_i ) A[A_i[1:0]] <= D_i;
			end
			4'b1100 : begin	
				if( wr_i ) case( D_i[7:6] )
					2'b01 : romflags[D_i[5:0]] <= 1'b0;		
					2'b10 : romflags[D_i[5:0]] <= 1'b1;		
					2'b11 : romflags <= 64'd0;					
				endcase
			end
			4'b1111 : begin
				if( wr_i ) begin
					cpc_pause_o <= D_i[7];
					control_ops <= D_i[6];
				end
				else
				if( rd_i ) DOUT <= {cpc_pause_ack_i,control_ops,6'd0};
			end
			default: ;
		endcase
	end
	always @(posedge clk_i or posedge reset_i)
	if( reset_i ) wait_o <= 1'b0;
	else begin
		if( ( A_i == 4'd0 ) && (rd_rise) ) wait_o <= 1'b1;
		else if( mem_valid_i | ~mem_busy_i ) wait_o <= 1'b0;
	end
endmodule