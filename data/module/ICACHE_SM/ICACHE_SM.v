module ICACHE_SM ( BCLK, BRESET, IO_SPACE, MDONE, IO_READY, MMU_HIT, CA_HIT, READ, PTE_ACC,
				   USE_CA, PTB_WR, PTB_SEL, USER, PROT_ERROR,
				   DRAM_ACC, IO_RD, IO_ACC, IC_PREQ, ACC_OK, HIT_ALL, CUPDATE, AUX_DAT, NEW_PTB, PTB_ONE );
	input			BCLK;
	input			BRESET;
	input			IO_SPACE;
	input			MDONE;		
	input			IO_READY;
	input			MMU_HIT,CA_HIT;
	input			READ;
	input			PTE_ACC;
	input			USE_CA;
	input			PTB_WR,PTB_SEL;
	input			USER;
	input			PROT_ERROR;
	output	reg		DRAM_ACC,IO_RD;
	output			IO_ACC;
	output			IC_PREQ;
	output			ACC_OK;
	output			HIT_ALL;
	output			CUPDATE;
	output			AUX_DAT;
	output	reg		NEW_PTB,PTB_ONE;
	reg		 [3:0]	new_state;
	reg				rd_done;
	reg				card_flag;
	reg				rd_rdy;
	wire			io_busy;
	wire			dram_go;
	wire			rd_ende;
	wire			do_ca_rd;
	assign rd_ende = CA_HIT | rd_rdy;	
	always @(	 READ	 	
			  or PROT_ERROR	
			  or IO_SPACE	
			  or io_busy	
			  or MMU_HIT	
			  or rd_ende	
			  or DRAM_ACC	
			  or PTE_ACC )	
		casex ({READ,PROT_ERROR,IO_SPACE,io_busy,MMU_HIT,rd_ende,DRAM_ACC,PTE_ACC})
		  8'b10_xx_0xx_0 : new_state = 4'b0100;	
		  8'b10_10_1xx_x : new_state = 4'b0001;
		  8'b10_0x_100_x : new_state = 4'b1010;	
		  default 		 : new_state = 4'b0;
		endcase
	assign IO_ACC   = new_state[0];	
	assign dram_go  = new_state[1];
	assign IC_PREQ  = new_state[2];	
	assign do_ca_rd = new_state[3];
	assign HIT_ALL = MMU_HIT & CA_HIT;	
	always @(posedge BCLK or negedge BRESET)
		if (!BRESET) card_flag <= 1'b0;
			else card_flag <= (do_ca_rd & ~rd_rdy) | (card_flag & ~MDONE);
	assign CUPDATE = card_flag & USE_CA & MDONE;	
	always @(posedge BCLK) rd_rdy <= card_flag & MDONE;	
	assign AUX_DAT = rd_rdy;
	always @(posedge BCLK) if (dram_go) DRAM_ACC <= 1'b1;
							 else
								DRAM_ACC <= DRAM_ACC & ~MDONE & BRESET;
	always @(posedge BCLK)
	  begin
		if (IO_ACC) IO_RD <= READ;  else IO_RD <= IO_RD & ~IO_READY & BRESET;
	  end
	assign io_busy = IO_RD | rd_done;	
	always @(posedge BCLK) rd_done <= READ & IO_READY;	
	assign ACC_OK = IO_SPACE ? rd_done : (READ & MMU_HIT & rd_ende);
	always @(posedge BCLK) NEW_PTB <= PTB_WR;			
	always @(posedge BCLK) if (PTB_WR) PTB_ONE <= PTB_SEL;
endmodule