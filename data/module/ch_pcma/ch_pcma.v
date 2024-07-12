module ch_pcma(
	input CLK,
	input CLK_SAMP,
	input nRESET,
	input FLAGMASK,
	output reg END_FLAG,
	input KEYON, KEYOFF,
	input [11:0] JEDI_DOUT,
	input [15:0] ADDR_START,
	input [15:0] ADDR_STOP,
	input [7:0] VOLPAN,				
	output [21:0] ROM_ADDR,
	output reg [3:0] DATA,
	output reg [9:0] ADPCM_STEP,	
	input [7:0] ROM_DATA,
	output reg [15:0] SAMPLE_OUT
);
	reg RUN;
	reg [1:0] ROM_BANK;
	reg [19:0] ADDR_CNT;
	reg NIBBLE;
	reg [11:0] ADPCM_ACC;
	reg SET_FLAG;
	reg PREV_FLAGMASK;
	assign ROM_ADDR = { ROM_BANK, ADDR_CNT };
	always @(posedge CLK)
	begin
		if (!nRESET)
		begin
			SET_FLAG <= 0;			
			PREV_FLAGMASK <= 0;	
			RUN <= 0;
		end
		else
		begin
			if (KEYON)
			begin
				ADDR_CNT <= { ADDR_START[11:0], 8'h0 };
				ROM_BANK <= ADDR_START[13:12];	
				END_FLAG <= 0;
				NIBBLE <= 0;		
				ADPCM_ACC <= 0;
				ADPCM_STEP <= 0;
				RUN <= 1;
			end
			if (KEYOFF)
				RUN <= 0;
			if (RUN && CLK_SAMP)
			begin
				if ((FLAGMASK == 1) && (PREV_FLAGMASK == 0))
					END_FLAG <= 0;
				PREV_FLAGMASK <= FLAGMASK;
				if (ADDR_CNT[19:8] == ADDR_STOP[11:0])
				begin
					if (SET_FLAG == 0)
					begin
						SET_FLAG <= 1;
						END_FLAG <= ~FLAGMASK;
					end
				end
				else
				begin
					SET_FLAG <= 0;
					if (NIBBLE)
					begin
						DATA <= ROM_DATA[3:0];
						ADDR_CNT <= ADDR_CNT + 1'b1;
					end
					else
						DATA <= ROM_DATA[7:4];
					ADPCM_ACC <= ADPCM_ACC + JEDI_DOUT;
					case (DATA[2:0])
						0, 1, 2, 3 :
						begin
							if (ADPCM_STEP >= 16)
								ADPCM_STEP <= ADPCM_STEP - 10'd16;
							else
								ADPCM_STEP <= 0;
						end
						4 :
						begin
							if (ADPCM_STEP <= (768 - 32))
								ADPCM_STEP <= ADPCM_STEP + 10'd32;
							else
								ADPCM_STEP <= 768;
						end
						5 :
						begin
							if (ADPCM_STEP <= (768 - 80))
								ADPCM_STEP <= ADPCM_STEP + 10'd80;
							else
								ADPCM_STEP <= 768;
						end
						6 :
						begin
							if (ADPCM_STEP <= (768 - 112))
								ADPCM_STEP <= ADPCM_STEP + 10'd112;
							else
								ADPCM_STEP <= 768;
						end
						7 :
						begin
							if (ADPCM_STEP <= (768 - 144))
								ADPCM_STEP <= ADPCM_STEP + 10'd144;
							else
								ADPCM_STEP <= 768;
						end
					endcase
					SAMPLE_OUT <= ADPCM_ACC[11] ? { 4'b1111, ADPCM_ACC } : { 4'b0000, ADPCM_ACC };
					NIBBLE <= ~NIBBLE;
				end
			end
		end
	end
endmodule