module CCD_Capture_1(	
					iDATA,
					iFVAL,
					iLVAL,
					iSTART,
					iEND,
					iCLK,
					iRST,
					oDATA,
					oDVAL,
					oX_Cont,
					oY_Cont,
					oFrame_Cont,
					oADDRESS,
					oLVAL
					);
input	[11:0]	iDATA;
input			iFVAL;
input			iLVAL;
input			iSTART;
input			iEND;
input			iCLK;
input			iRST;
output	[11:0]	oDATA;
output	[15:0]	oX_Cont;
output	[15:0]	oY_Cont;
output	[31:0]	oFrame_Cont;
output	[23:0]   oADDRESS;
output			oDVAL;
output         oLVAL;
reg             temp_oLVAL;
reg				Pre_FVAL;
reg				mCCD_FVAL;
reg				mCCD_LVAL;
reg		[11:0]	mCCD_DATA;
reg		[15:0]	X_Cont;
reg		[15:0]	Y_Cont;
reg		[31:0]	Frame_Cont;
reg      [23:0]   regADDRESS;
reg				   mSTART;
parameter COLUMN_WIDTH = 1280;
assign	oX_Cont		=	X_Cont;
assign	oY_Cont		=	Y_Cont;
assign	oFrame_Cont	=	Frame_Cont;
assign	oDATA		=	mCCD_DATA;
assign	oDVAL		=	mCCD_FVAL&mCCD_LVAL;
assign   oADDRESS = regADDRESS;
assign   oLVAL = temp_oLVAL;
always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
	mSTART	<=	0;
	else
	begin
		if(iSTART)
		mSTART	<=	1;
		if(iEND)
		mSTART	<=	0;		
	end
end
always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
	begin
		Pre_FVAL	<=	0;
		mCCD_FVAL	<=	0;
		mCCD_LVAL	<=	0;
		X_Cont		<=	0;
		Y_Cont		<=	0;
	end
	else
	begin
		Pre_FVAL	<=	iFVAL;
		if( ({Pre_FVAL,iFVAL}==2'b01) && mSTART )
		mCCD_FVAL	<=	1;
		else if({Pre_FVAL,iFVAL}==2'b10)
		mCCD_FVAL	<=	0;
		mCCD_LVAL	<=	iLVAL;
		if(mCCD_FVAL)
		begin
			if(mCCD_LVAL)
			begin
				if(X_Cont<(COLUMN_WIDTH-1))
				X_Cont	<=	X_Cont+1;
				else
				begin
					X_Cont	<=	0;
					Y_Cont	<=	Y_Cont+1;
				end
				if(X_Cont>=320 &&  X_Cont<960 && Y_Cont>=120 && Y_Cont<600)
				begin
				   temp_oLVAL <=1'b1;
				   regADDRESS <=regADDRESS+1;
				end
			   else 
				   temp_oLVAL <=1'b0;
			end
		end
		else
		begin
			X_Cont	<=	0;
			Y_Cont	<=	0;
			regADDRESS<=0;
		end
	end
end
always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
	Frame_Cont	<=	0;
	else
	begin
		if( ({Pre_FVAL,iFVAL}==2'b01) && mSTART )
		Frame_Cont	<=	Frame_Cont+1;
	end
end
always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
		mCCD_DATA	<=	0;
	else if (iLVAL)
		mCCD_DATA	<=	iDATA;
	else
		mCCD_DATA	<=	0;	
end			
reg	ifval_dealy;
wire ifval_fedge;	
reg	[15:0]	y_cnt_d;
always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
		y_cnt_d	<=	0;
	else
		y_cnt_d	<=	Y_Cont;	
end
always@(posedge iCLK or negedge iRST)
begin
	if(!iRST)
		ifval_dealy	<=	0;
	else
		ifval_dealy	<=	iFVAL;	
end
assign ifval_fedge = ({ifval_dealy,iFVAL}==2'b10)?1:0;  
endmodule