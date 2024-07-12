module CONFIG_REGS ( BCLK, BRESET, WREN, LD_OUT, OPCODE, SRC1, WRADR, PC_ARCHI, USER, PCMATCH, DBG_HIT, READ,
					 CFG, MCR, PTB_WR, PTB_SEL, IVAR, CINV, Y_INIT, DSR, DBG_TRAPS, DBG_IN );
	input			BCLK,BRESET;
	input			WREN,LD_OUT;
	input	 [7:0]	OPCODE;
	input	[31:0]	SRC1;
	input	 [5:0]	WRADR;
	input	[31:0]	PC_ARCHI;
	input			USER;
	input			PCMATCH;
	input			DBG_HIT;
	input			READ;
	output	[12:0]	CFG;
	output	 [3:0]	MCR;
	output			PTB_WR;
	output			PTB_SEL;
	output	 [1:0]	IVAR;
	output	 [3:0]	CINV;
	output			Y_INIT;
	output	 [3:0]	DSR;
	output	 [2:0]	DBG_TRAPS;
	output	[40:2]	DBG_IN;
	reg		 [3:0]	MCR;
	reg		[12:0]	CFG;
	reg		 [1:0]	old_cfg;
	reg				PTB_WR,PTB_SEL;
	reg				ivarreg;
	reg		 [1:0]	ci_all,ci_line;
	reg				check_y;
	wire			ld_cfg,ld_mcr,do_cinv;
	wire			init_ic,init_dc;
	wire			op_ok;
	assign op_ok = (OPCODE == 8'h6A);	
	assign ld_cfg  = op_ok & (WRADR == 6'h1C)	   & WREN;
	assign ld_mcr  = op_ok & (WRADR == 6'd9)	   & WREN;
	assign do_cinv = op_ok & (WRADR[5:4] == 2'b11) & WREN;
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) CFG <= 13'h0;
			else if (ld_cfg) CFG <= SRC1[12:0];
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) MCR <= 4'h0;
			else if (ld_mcr) MCR <= SRC1[3:0];
	always @(posedge BCLK) ivarreg <= op_ok & (WRADR[5:1] == 5'd7) & WREN;	
	assign IVAR = {ivarreg,PTB_SEL};
	always @(posedge BCLK) PTB_WR  <= op_ok & (WRADR[5:1] == 5'd6) & WREN;	
	always @(posedge BCLK) PTB_SEL <= WRADR[0];
	always @(posedge BCLK) old_cfg <= {CFG[11],CFG[9]};
	always @(posedge BCLK) ci_all  <= do_cinv &  WRADR[2] ? WRADR[1:0] : 2'b0;	
	always @(posedge BCLK) ci_line <= do_cinv & ~WRADR[2] ? WRADR[1:0] : 2'b0;	
	assign init_ic = old_cfg[1] & (~CFG[11] | ci_all[1]);
	assign init_dc = old_cfg[0] & (~CFG[9]  | ci_all[0]);
	assign CINV = {init_ic,ci_line[1],init_dc,ci_line[0]};
	always @(posedge BCLK) check_y <= ld_cfg | do_cinv;
	assign Y_INIT = check_y & ~init_ic & ~init_dc;	
	reg		 [3:0]	DSR;
	reg		[12:0]	dcr;
	reg		[31:0]	bpc;
	reg		[31:2]	car;
	wire			op_dbg,ld_dcr,ld_bpc,ld_dsr,ld_car;
	wire			enable;
	assign op_dbg = (OPCODE == 8'h76);
	assign ld_dcr = op_dbg & (WRADR == 6'h11) & WREN;
	assign ld_bpc = op_dbg & (WRADR == 6'h12) & WREN;
	assign ld_dsr = op_dbg & (WRADR == 6'h13) & WREN;
	assign ld_car = op_dbg & (WRADR == 6'h14) & WREN;
	assign enable = dcr[12] & (USER ? dcr[10] : dcr[11]);	
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) dcr <= 13'd0;
			else if (ld_dcr) dcr <= {SRC1[23:19],SRC1[7:0]};
	always @(posedge BCLK) if (ld_bpc) bpc <= SRC1;
	always @(posedge BCLK) if (ld_car) car <= SRC1[31:2];
	assign DBG_IN = {(dcr[12] & dcr[11]),(dcr[12] & dcr[10]),(dcr[7] & dcr[6]),(dcr[7] & dcr[5]),dcr[4:0],car};
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) DSR <= 4'd0;
		  else
			if (ld_dsr) DSR <= SRC1[31:28];
			  else
				begin
				  DSR[3] <= DBG_HIT ? READ : DSR[3];
				  DSR[2] <= DSR[2] | PCMATCH;
				  DSR[1] <= DSR[1];
				  DSR[0] <= DSR[0] | DBG_HIT;
				end
	assign DBG_TRAPS[0] = enable & dcr[9] & (PC_ARCHI == bpc);	
	assign DBG_TRAPS[1] = DBG_HIT;	
	assign DBG_TRAPS[2] = dcr[8];	
endmodule