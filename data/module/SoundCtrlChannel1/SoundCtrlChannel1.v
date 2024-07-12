module SoundCtrlChannel1 
  (
    input wire		iClock,			
    input wire		iReset,
    input wire		iOsc64,			
	input wire		iOsc256,		
	input wire 		iOsc128,		
    input wire		iOsc262k,		
    input wire [7:0] iNR10,
    input wire [7:0] iNR11,
    input wire [7:0] iNR12,
    input wire [7:0] iNR13,
    input wire [7:0] iNR14,            
    output reg [4:0]	oOut,
    output wire oOnFlag    
  );
 	reg [2:0] rSweepShifts;
 	reg rSweepMode;
 	reg [2:0] rSweepTime;
 	reg [17:0] rSweepCounter;
	reg [11:0] rSoundFrequencyNew;
	reg [5:0] rLength;
 	reg [19:0] rLengthCounter;	
	reg [1:0] rDutyCycle;
	reg rTimedMode;
 	reg rLengthComplete; 	
	reg rTone;
	reg [10:0] rSoundFrequency;
	reg [10:0] rSoundFrequencyCounter;
	reg [3:0] rStep;
	reg [18:0] rStepTime;
	reg [18:0] rStepCounter;
	reg [3:0] rInitialValue;
	reg rEvelopeMode;
 	wire [4:0] up_value, down_value;
	always @(posedge iClock) begin
		if (iReset || iNR14[7]) begin 
			rLength 		<= iNR11[5:0];
			rLengthCounter 	<= 64-iNR11[5:0]; 	
			rLengthComplete <= 0;			
			rDutyCycle		<= iNR11[7:6];
			rTimedMode <= iNR14[6];
			rStepTime		<= iNR12[2:0];
			rStepCounter 	<= iNR12[2:0]; 
			rEvelopeMode	<= iNR12[3];
			rInitialValue	<= iNR12[7:4];
			rStep 			<= iNR12[7:4];
			rTone 			<= 0;
			rSoundFrequency[10:0] <= 2048-{iNR14[2:0],iNR13[7:0]};
			rSoundFrequencyCounter[10:0] <= 2048-{iNR14[2:0],iNR13[7:0]}; 
			rSoundFrequencyNew <= 2048-{iNR14[2:0],iNR13[7:0]};
			rSweepShifts <= iNR10[2:0];
			rSweepMode <= iNR10[3];
			rSweepTime <= iNR10[6:4];
			rSweepCounter <= iNR10[6:4];
		end
	end
  	always @(posedge iOsc64) begin
  		if (rStepTime != 0) begin 			
	  		if (rStepCounter ==1 ) begin
	  			rStepCounter <= rStepTime; 	
				if(rEvelopeMode) begin 		
					rStep <= ((rStep == 4'hF) ? rStep : rStep+1); 
				end
				else begin
					rStep <= ((rStep == 4'h0) ? rStep : rStep-1); 
				end
	  		end
	  		else begin
	  			rStepCounter <= rStepCounter-1;
	  		end  	
	  	end
	end
	always @(posedge iOsc262k) begin
		if (rSoundFrequencyCounter ==0) begin
			rSoundFrequencyCounter <= rSoundFrequency;
			rTone <= ~rTone;
		end
		else begin
			rSoundFrequencyCounter <= rSoundFrequencyCounter-1;
		end
	end
	always @(posedge iOsc128) begin 
		if (rSweepCounter ==1 && rSweepShifts != 0 && rSweepTime > 0) begin 
			if (rSweepMode) begin
				rSoundFrequencyNew <= rSoundFrequency + (rSoundFrequency >> rSweepShifts);
			end
			else begin
				rSoundFrequencyNew <= rSoundFrequency - (rSoundFrequency >> rSweepShifts);			
			end
		end
		if (rSweepCounter ==0 && rSweepTime > 0) begin 
			if (rSoundFrequencyNew == 1 && rSoundFrequency == 1) begin 
				rLengthComplete = 1'b1 ;
			end
			else if (rSoundFrequencyNew <= 2047) begin 
				rSoundFrequency <= rSoundFrequencyNew;
			end
			rSweepCounter <= rSweepTime;
		end
		else begin
			rSweepCounter = rSweepCounter-1;
		end
	end
	always @(posedge iOsc256) begin
		if (rLengthCounter == 0) begin
			rLengthCounter <= 64-rLength;
			rLengthComplete <= (rTimedMode || rLengthComplete); 
		end
		else begin
			rLengthCounter <= rLengthCounter-1;
		end
	end
	assign up_value = 5'd15 + rStep;
	assign down_value = 5'd15 - rStep;
	always @(posedge iClock) begin
		if (rLengthComplete) begin
			oOut[4:0] <= 5'd15;
		end
		else begin
			if (rTone) begin
				oOut[4:0] <= up_value[4:0];
			end
			else begin
				oOut[4:0] <= down_value[4:0];
			end
		end
	end
assign oOnFlag = rLengthComplete;
endmodule