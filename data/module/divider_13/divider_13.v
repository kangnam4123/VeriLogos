module divider_13(
	opa, opb, quo, rem 
	);   
   input  [10:0]  opa;
   input  [3:0]  opb;
   output [10:0]  quo, rem;
   reg [10:0] quo, rem;
   reg [10:0]    quotient0;
   reg [10:0]    dividend_copy0, diff0;
   reg [10:0]    divider_copy0;
   wire [10:0]   remainder0;
   reg [10:0]    quotient1;
   reg [10:0]    dividend_copy1, diff1;
   reg [10:0]    divider_copy1;
   wire [10:0]   remainder1;
   reg [10:0]    quotient2;
   reg [10:0]    dividend_copy2, diff2;
   reg [10:0]    divider_copy2;
   wire [10:0]   remainder2;
   reg [10:0]    quotient3;
   reg [10:0]    dividend_copy3, diff3;
   reg [10:0]    divider_copy3;
   wire [10:0]   remainder3;
   reg [10:0]    quotient4;
   reg [10:0]    dividend_copy4, diff4;
   reg [10:0]    divider_copy4;
   wire [10:0]   remainder4;
   reg [10:0]    quotient5;
   reg [10:0]    dividend_copy5, diff5;
   reg [10:0]    divider_copy5;
   wire [10:0]   remainder5;
   reg [10:0]    quotient6;
   reg [10:0]    dividend_copy6, diff6;
   reg [10:0]    divider_copy6;
   wire [10:0]   remainder6;
   reg [10:0]    quotient7;
   reg [10:0]    dividend_copy7, diff7;
   reg [10:0]    divider_copy7;
   wire [10:0]   remainder7;
   reg [10:0]    quotient8;
   reg [10:0]    dividend_copy8, diff8;
   reg [10:0]    divider_copy8;
   wire [10:0]   remainder8;
always @ (opa or opb)
begin
 quotient0 = 11'b00000000000;
 dividend_copy0 = opa;
 divider_copy0 = {opb,7'b0000000};
 diff1 = dividend_copy0 - divider_copy0;
 quotient1 [10:1] = quotient0[9:0] ;
 if (!diff1[10]) 
 begin
 dividend_copy1 = diff1;
 quotient1[0] = 1'b1;
 end
else   
begin
dividend_copy1 = dividend_copy0;
 quotient1[0] = 1'b0;
end
 divider_copy1 = (divider_copy0 >> 1);
 diff2 = dividend_copy1 - divider_copy1;
 quotient2[10:1]  = quotient1 [9:0] ;
 if (!diff2[10])
 begin
 dividend_copy2 = diff2;
 quotient2[0] = 1'b1;
 end
 else
begin
dividend_copy2 = dividend_copy1;
 quotient2[0] = 1'b0;
end
 divider_copy2 = divider_copy1 >> 1;
 diff3 = dividend_copy2 - divider_copy2;
 quotient3[10:1]  = quotient2 [9:0] ;
 if (!diff3[10])
 begin
 dividend_copy3 = diff3;
 quotient3[0] = 1'b1;
 end
 else
begin
dividend_copy3 = dividend_copy2;
 quotient3[0] = 1'b0;
end
 divider_copy3 = divider_copy2 >> 1;
 diff4 = dividend_copy3 - divider_copy3;
 quotient4[10:1]  = quotient3 [9:0] ;
 if (!diff4[10])
 begin
 dividend_copy4 = diff4;
 quotient4[0] = 1'b1;
 end
 else
begin
dividend_copy4 = dividend_copy3;
 quotient4[0] = 1'b0;
end
 divider_copy4 = divider_copy3 >> 1;
 diff5 = dividend_copy4 - divider_copy4;
 quotient5[10:1]  = quotient4 [9:0] ;
 if (!diff5[10])
 begin
 dividend_copy5 = diff5;
 quotient5[0] = 1'b1;
 end
 else
begin
dividend_copy5 = dividend_copy4;
 quotient5[0] = 1'b0;
end
 divider_copy5 = divider_copy4 >> 1;
 diff6 = dividend_copy5 - divider_copy5;
 quotient6[10:1]  = quotient5 [9:0] ;
 if (!diff6[10])
 begin
 dividend_copy6 = diff6;
 quotient6[0] = 1'b1;
 end
 else
begin
dividend_copy6 = dividend_copy5;
 quotient6[0] = 1'b0;
end
 divider_copy6 = divider_copy5>> 1;
 diff7 = dividend_copy6 - divider_copy6;
 quotient7[10:1]  = quotient6 [9:0] ;
 if (!diff7[10])
 begin
 dividend_copy7 = diff7;
 quotient7[0] = 1'b1;
 end
 else
begin
dividend_copy7 = dividend_copy6;
 quotient7[0] = 1'b0;
end
 divider_copy7 = divider_copy6>> 1;
 diff8 = dividend_copy7 - divider_copy7;
 quotient8[10:1]  = quotient7 [9:0] ;
 if (!diff8[10])
 begin
 dividend_copy8 = diff8;
 quotient8[0] = 1'b1;
 end
 else
begin
dividend_copy8 = dividend_copy7;
 quotient8[0] = 1'b0;
end
 divider_copy8 = divider_copy7>> 1;
quo = quotient8;
rem =  dividend_copy8;
end
endmodule