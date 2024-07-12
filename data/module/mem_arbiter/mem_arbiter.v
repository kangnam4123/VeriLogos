module mem_arbiter (
	input			clock_i,
	input			reset_i,
	output reg [22:0]	adr_o,
	output [15:0]	dat_o,
	output [1:0]	dm_o,
	output reg		rd_o,
	output reg		wr_o,
	output reg		enable_o,
	input				busy_i,
	input			valid_i,
	input 		 	req1_i,
	output reg	 	ack1_o,
	input [22:0]	adr1_i,
	input [15:0]	dat1_i,
	input [1:0]		dm1_i,
	input			rd1_i,
	input			wr1_i,
	input 		 	req2_i,
	output reg	 	ack2_o,
	input [22:0]	adr2_i,
	input [15:0]	dat2_i,
	input [1:0]		dm2_i,
	input			rd2_i,
	input			wr2_i,
	input 		 	req3_i,
	output reg	 	ack3_o,
	input [22:0]	adr3_i,
	input [15:0]	dat3_i,
	input [1:0]		dm3_i,
	input			rd3_i,
	input			wr3_i,
	input 		 	req4_i,
	output reg	 	ack4_o,
	input [22:0]	adr4_i,
	input [15:0]	dat4_i,
	input [1:0]		dm4_i,
	input			rd4_i,
	input			wr4_i
	);
	parameter IDLE = 0, ACTIVE = 1, INCYCLE = 2; 
	reg [2:0] 	state = IDLE, last_state = IDLE;
	reg [2:0]	cntr = 0;
	reg rd = 0, wr = 0;
	reg ack1 = 0, ack2 = 0, ack3 = 0, ack4 = 0;
	assign dat_o = (ack1_o) ? dat1_i : (ack2_o) ? dat2_i : (ack3_o) ? dat3_i : (ack4_o) ? dat4_i : 16'd0; 
	assign dm_o = (ack1_o) ? dm1_i : (ack2_o) ? dm2_i : (ack3_o) ? dm3_i : (ack4_o) ? dm4_i : 2'd0; 
	always @(posedge clock_i)
	if( reset_i ) state <= IDLE;
	else case( state )
		IDLE : if( ~valid_i ) begin
			if( req1_i & (rd1_i | wr1_i) ) begin
				state <= ACTIVE;
				ack1 <= 1'b1;
				adr_o <= adr1_i;
				if( rd1_i ) begin
					rd <= 1'b1;
					wr <= 1'b0;
				end
				else begin
					rd <= 1'b0;
					if( wr1_i ) wr <= 1'b1;
					else wr <= 1'b0;
				end
			end
			else
			if( req2_i & (rd2_i | wr2_i) ) begin
				state <= ACTIVE;
				adr_o <= adr2_i;
				ack2 <= 1'b1;
				if( rd2_i ) begin
					rd <= 1'b1;
					wr <= 1'b0;
				end
				else begin
					rd <= 1'b0;
					if( wr2_i ) wr <= 1'b1;
					else wr <= 1'b0;
				end
			end
			else
			if( req3_i & (rd3_i | wr3_i) ) begin
				state <= ACTIVE;
				adr_o <= adr3_i;
				ack3 <= 1'b1;
				if( rd3_i ) begin
					rd <= 1'b1;
					wr <= 1'b0;
				end
				else begin
					rd <= 1'b0;
					if( wr3_i ) wr <= 1'b1;
					else wr <= 1'b0;
				end
			end
			else
			if( req4_i & (rd4_i | wr4_i) ) begin
				state <= ACTIVE;
				adr_o <= adr4_i;
				ack4 <= 1'b1;
				if( rd4_i ) begin
					rd <= 1'b1;
					wr <= 1'b0;
				end
				else begin
					rd <= 1'b0;
					if( wr4_i ) wr <= 1'b1;
					else wr <= 1'b0;
				end
			end 
		end
		ACTIVE : if( valid_i ) begin
 			state <= INCYCLE;
 			cntr <= 3'd7;	
		end
		INCYCLE : begin
			ack1 <= 0;
			ack2 <= 0;
			ack3 <= 0;
			ack4 <= 0;			
			if( cntr == 0 ) state <= IDLE;
			else cntr <= cntr - 1'b1;
		end
		default: state <= IDLE; 
	endcase
	reg pending_acknowledgement = 0;
	always @(negedge clock_i)
	begin
		case( state )
			IDLE: begin
				ack1_o <= 0;
				ack2_o <= 0;
				ack3_o <= 0;
				ack4_o <= 0;
				rd_o <= 0;
				wr_o <= 0;
				enable_o <= 0;
				last_state <= IDLE;
				pending_acknowledgement <= 1'b1;
			end
			ACTIVE: begin	
				if( pending_acknowledgement ) begin
					ack1_o <= ack1;
					ack2_o <= ack2;
					ack3_o <= ack3;
					ack4_o <= ack4;
					rd_o <= rd;
					wr_o <= wr;
					enable_o <= 1;
					if( busy_i ) pending_acknowledgement <= 1'b0;
				end
				else
				begin
					enable_o <= 0;
					rd_o <= 0;
					wr_o <= 0;
				end
			end
			INCYCLE : begin
				enable_o <= 0;
				rd_o <= 0;
				wr_o <= 0;
			end
		endcase
	end
endmodule