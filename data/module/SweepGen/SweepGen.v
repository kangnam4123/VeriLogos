module SweepGen ( clock, reset, aclr, enable, strobe, phase, rbusCtrl, rbusData);
	parameter FREQADDR 	= 0;
	parameter RESOLUTION = 32;
	parameter freqStart  = 32'd0;
	parameter freqEnd    = 32'd536870912;
	parameter freqDelta  = 32'd1677722;
	input    clock, reset, aclr, enable, strobe;
	output  reg [RESOLUTION-1:0] phase;
	reg [RESOLUTION-1:0] freq;
	input   wire  [11:0] 		  rbusCtrl;  
	inout   wire  [7:0]  		  rbusData;  
	always @(posedge clock)
	begin
	  if(reset | aclr)
			begin
				phase <= #1 32'b0;
				freq <=  #1 freqStart; 
			end
	  else if(enable & strobe)
		begin
			phase <= #1 phase + freq;
			freq <= #1 (freq >= freqEnd)? freqStart : (freq + freqDelta) ;
		end
	end
endmodule