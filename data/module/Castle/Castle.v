module Castle(clk_vga, CurrentX, CurrentY, mapData, wall);
	input clk_vga;
	input [9:0]CurrentX;
	input [8:0]CurrentY;
	input [7:0]wall;
	output [7:0]mapData;
	reg [7:0]mColor;
	always @(posedge clk_vga) begin
		if(CurrentX >= 0 && CurrentX <= 31)
			mColor[7:0] <= wall;
		else if(CurrentX >= 608)
			mColor[7:0] <= wall;
		else if(CurrentY >=441 && ( (CurrentX <= 256) || (CurrentX >= 384) ) )
			mColor[7:0] <= wall;
		else if(CurrentY <= 39 && ( (CurrentX <= 159) || (CurrentX >= 480) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 160 && CurrentX <= 175) && (
			(CurrentY <= 199) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 176 && CurrentX <= 191) && (
			(CurrentY >= 40 && CurrentY <= 199) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 192 && CurrentX <= 207) && (
			(CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 208 && CurrentX <= 223) && (
			(CurrentY >= 40 && CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 224 && CurrentX <= 239) && (
			(CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 240 && CurrentX <= 255) && (
			(CurrentY >= 40 && CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 256 && CurrentX <= 271) && (
			(CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 272 && CurrentX <= 287) && (
			(CurrentY >= 120 && CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 288 && CurrentX <= 351) && (
			(CurrentY >= 120 && CurrentY <= 279) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 352 && CurrentX <= 367) && (
			(CurrentY >= 120 && CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 368 && CurrentX <= 383) && (
			(CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 384 && CurrentX <= 399) && (
			(CurrentY >= 40 && CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 400 && CurrentX <= 415) && (
			(CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 416 && CurrentX <= 431) && (
			(CurrentY >= 40 && CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 432 && CurrentX <= 447) && (
			(CurrentY <= 359) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 448 && CurrentX <= 463) && (
			(CurrentY >= 40 && CurrentY <= 199) ) )
			mColor[7:0] <= wall;
		else if( (CurrentX >= 464 && CurrentX <= 479) && (
			(CurrentY <= 199) ) )
			mColor[7:0] <= wall;
		else
			mColor[7:0] <= 8'b10110110;
	end
	assign mapData = mColor;
endmodule