module salsa_fsm (hash_clk, reset, SMixInRdy, nonce, XCtl, mixfeedback, addrsourceMix, loadMixOut, nonce_2, ram_wren, writeaddr, Set_SMixOutRdy, Clr_SMixInRdy );
	parameter XSnull = 0, XSload = 1, XSmix = 2, XSram = 3;
	input hash_clk;
	input reset;
	input SMixInRdy;
	input [31:0] nonce;
	output reg Set_SMixOutRdy = 1'b0;
	output reg Clr_SMixInRdy = 1'b0;
	parameter R_IDLE=0, R_INIT=1, R_WRITE=2, R_MIX=3, R_INT=4;
	reg [2:0] mstate = R_IDLE;
	reg [10:0] cycle = 11'd0;
	reg [6:0] mcount = 6'd0;		
	reg doneROM = 1'd0;				
	output reg mixfeedback = 1'b0;
	output reg addrsourceMix = 1'b0;
	output reg [1:0] XCtl = XSnull;
	output reg loadMixOut = 1'b0;
	output reg ram_wren = 1'b0;
	reg [31:0] nonce_1 = 32'd0;
	output reg [31:0] nonce_2 = 32'd0;
	output reg [9:0] writeaddr = 10'd0;
	always @ (posedge hash_clk)
	begin
		Set_SMixOutRdy <= 1'b0;
		Clr_SMixInRdy <= 1'b0;
		XCtl <= XSnull;
		loadMixOut <= 1'b0;
		ram_wren <= 1'b0;
		if (reset)
			mstate <= R_IDLE;
		else
		begin
			case (mstate)
				R_IDLE: begin
					writeaddr <= 0;
					mcount <= 0;
					mixfeedback <= 1'b0;
					addrsourceMix <= 1'b0;
					doneROM <= 1'b0;
					if (SMixInRdy)
					begin
						XCtl <= XSload;
						mstate <= R_INIT;
						Clr_SMixInRdy <= 1;
						nonce_1 <= nonce;
					end
				end
				R_INIT: begin
						mstate <= R_WRITE;
						ram_wren <= 1'b1;
				end
				R_WRITE: begin
					mcount <= mcount + 6'd1;
					if (mcount==0)
					begin
						mixfeedback <= 1'b1;
						if (writeaddr==1023)
							doneROM <= 1'b1;			
						writeaddr <= writeaddr + 10'd1;
					end
					if (mcount==8)
						mixfeedback <= 1'b1;
					if (mcount == 6 || mcount == 14)
						XCtl <= XSmix;
					if (mcount == 7 || mcount == 15)
						mixfeedback <= 1'b0;
					if (mcount == 14 && doneROM)
						addrsourceMix <= 1'b1;
					if (mcount == 15)
					begin
						mcount <= 0;
						if (doneROM)
						begin
							cycle <= 0;
							mstate <= R_MIX;
						end
						else
						begin
							ram_wren <= 1'b1;
						end
					end
				end
				R_MIX: begin
					mcount <= mcount + 6'd1;
					if (mcount == 0)
						XCtl <= XSram;
					if (mcount == 1)
						mixfeedback <= 1'b0;
					if (mcount==2 || mcount==10)
						mixfeedback <= 1;
					if (mcount == 8 || mcount == 16)
						XCtl <= XSmix;
					if (mcount == 9 || mcount == 17)
						mixfeedback <= 1'b0;
					if (mcount == 17)
					begin
						mcount <= 0;
						cycle <= cycle + 11'd1;
						if (cycle == 1023)
						begin
							loadMixOut <= 1'b1;
							Set_SMixOutRdy <= 1'b1;
							nonce_2 <= nonce_1;
							mstate <= R_IDLE;
						end
					end
				end
			endcase
		end
	end	
endmodule