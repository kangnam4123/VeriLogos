module Seven_Segment_Display #(
										parameter	
										CLOCKFREQ	= 100,	
										DIGITS		= 4
										)
(
input		wire								CLK_I,
input		wire		[DIGITS*4-1:0]		DATA_I,
input		wire		[DIGITS-1:0]		DOTS_I,
output	reg		[DIGITS-1:0]		AN_O,
output	wire		[7:0]					CA_O
);
	parameter 	integer		DISP_FREQ			=	20*DIGITS;
	parameter	integer		DISP_FREQ_CYCLES	=	(CLOCKFREQ*1000/DISP_FREQ);	
	parameter					ZERO					=	7'b1000000;	
	parameter					ONE					=	7'b1111001;	
	parameter					TWO					=	7'b0100100;
	parameter					THREE					=	7'b0110000;
	parameter					FOUR					=	7'b0011001;
	parameter					FIVE					=	7'b0010010;
	parameter					SIX					=	7'b0000010;
	parameter					SEVEN					=	7'b1111000;		
	parameter					EIGHT					=	7'b0000000;
	parameter					NINE					=	7'b0010000;
	parameter					A						=	7'b0001000;	
	parameter					B						=	7'b0000011;
	parameter					C						=	7'b1000110;
	parameter					D						=	7'b0100001;
	parameter					E						=	7'b0000110;
	parameter					F						=	7'b0001110;
	parameter					DEFAULT				=	7'b0001001;	
	reg		[$clog2(DISP_FREQ_CYCLES)-1:0]		refreshCnt;
	reg		[$clog2(DIGITS)-1:0]						DigitNo;
	reg		[3:0]											Digit;
	reg		[6:0]											HexDigit;
	wire														Dot;
	wire														DisplayCLK;
	initial
		begin
			refreshCnt	=	'b0;
			DigitNo		=	'b0;
		end
	always@(Digit)
		case(Digit)
			0	:	HexDigit	=	ZERO;
			1	:	HexDigit	=	ONE;
			2	:	HexDigit	=	TWO;
			3	:	HexDigit	=	THREE;
			4	:	HexDigit	=	FOUR;
			5	:	HexDigit	=	FIVE;
			6	:	HexDigit	=	SIX;
			7	:	HexDigit	=	SEVEN;
			8	:	HexDigit	=	EIGHT;
			9	:	HexDigit	=	NINE;
			10	:	HexDigit	=	A;
			11	:	HexDigit	=	B;	
			12	:	HexDigit	=	C;
			13	:	HexDigit	=	D;	
			14	:	HexDigit	=	E;
			15	:	HexDigit	=	F;
			default:	HexDigit	=	DEFAULT;
		endcase
	always@(DATA_I,DigitNo)
		case(DigitNo)
        0   :  Digit = DATA_I[3:0];
        1  	:	Digit = DATA_I[7:4];
        2   :  Digit = DATA_I[11:8];
        3   :  Digit = DATA_I[15:12];
			default: Digit = DEFAULT;
		endcase
	assign	Dot	=	~DOTS_I[DigitNo];
	assign	CA_O	=	{Dot,HexDigit};
		always@(posedge CLK_I)
			if(refreshCnt	==	DISP_FREQ_CYCLES-1)
			refreshCnt	<=	'b0;
			else
			refreshCnt	<=	refreshCnt + 1'b1;
		always@(posedge CLK_I)
			if(refreshCnt	==	DISP_FREQ_CYCLES-1)
				if((DigitNo+1) ==	DIGITS)
				DigitNo	<=	'b0;
				else
				DigitNo	<=	DigitNo + 1'b1;
		always@(DigitNo)
			begin
				AN_O				<=	4'hF;
				AN_O[DigitNo]	<=	1'b0;
			end
endmodule