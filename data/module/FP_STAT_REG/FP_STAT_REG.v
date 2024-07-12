module FP_STAT_REG ( BCLK, BRESET, LFSR, UP_SP, UP_DP, TT_SP, TT_DP, WREN, WRADR, DIN, FSR, TWREN, FPU_TRAP, SAVE_PC);
	input			BCLK;
	input			BRESET;
	input			LFSR;	
	input			UP_SP,UP_DP;	
	input 	 [4:0]	TT_SP,TT_DP;
	input			WREN;	
	input	 [5:4]	WRADR;
	input 	[16:0] 	DIN;	
	output	[31:0] 	FSR;
	output			TWREN;
	output	reg		FPU_TRAP;
	output			SAVE_PC;
	reg		 [4:3]	trap_d;
	reg				update_d;
	reg				set_rm_d;
	reg		[10:0]	set_bits;
	reg		 [4:0]	flags;
	reg				rm_bit;
	wire			load_fsr;
	wire			update,update_i;
	wire	 [4:0]	trap;
	wire			uflag,iflag,rmflag;
	assign load_fsr = LFSR & WREN;
	assign trap = UP_SP ? TT_SP : TT_DP;
	assign TWREN = ~((UP_SP & (TT_SP[2:0] != 3'b0)) | (UP_DP & (TT_DP[2:0] != 3'b0)));
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) FPU_TRAP <= 1'b0;
		  else FPU_TRAP <= ~FPU_TRAP & ~TWREN;	
	assign update_i = (UP_SP | UP_DP) & ~FPU_TRAP;	
	always @(posedge BCLK) update_d	<= update_i;
	always @(posedge BCLK) trap_d	<= trap[4:3];
	always @(posedge BCLK) set_rm_d	<= WREN & (WRADR == 2'b10);
	assign update = update_d & ~FPU_TRAP;
	assign iflag  = (update & trap_d[4]) | flags[4];	
	assign uflag  = (update & trap_d[3]) | flags[3];	
	assign rmflag = (set_rm_d & ~FPU_TRAP) | rm_bit;	
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) flags[4:3] <= 2'b0;	
		  else
		  begin
			if (load_fsr) flags[4:3] <= {DIN[6],DIN[4]};
			  else
				if (update) flags[4:3] <= {iflag,uflag};
		  end
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) flags[2:0] <= 3'b0;	
		  else
		  begin
			if (load_fsr) flags[2:0] <= DIN[2:0];
			  else
				if (update_i) flags[2:0] <= trap[2:0];
		  end
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) rm_bit <= 1'b0;	
		  else
		  begin
			if (load_fsr) rm_bit <= DIN[16];
			  else
				if (set_rm_d & ~FPU_TRAP) rm_bit <= 1'b1;	
		  end
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) set_bits <= 11'b0;	
		  else
			if (load_fsr) set_bits <= {DIN[15:7],DIN[5],DIN[3]};
	assign FSR = {15'h0,rmflag,set_bits[10:2],iflag,set_bits[1],uflag,set_bits[0],flags[2:0]};
	assign SAVE_PC = (UP_SP | UP_DP) & ~FPU_TRAP;	
endmodule