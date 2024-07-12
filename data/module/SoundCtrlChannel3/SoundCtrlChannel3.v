module SoundCtrlChannel3 
  (
    input wire		iClock,			
    input wire		iReset,
	input wire		iOsc256,		
    input wire		iOsc262k,		
    input wire [7:0] iNR30,
    input wire [7:0] iNR31,
    input wire [7:0] iNR32,
    input wire [7:0] iNR33,
    input wire [7:0] iNR34,
    output reg [4:0]	oOut, 
    output wire oOnFlag
  );
	reg [8:0] rLength;
 	reg [19:0] rLengthCounter;	
	reg rTimedMode;
 	reg rLengthComplete; 	
	reg rTone;
	reg [10:0] rSoundFrequency;
	reg [10:0] rSoundFrequencyCounter;
	reg rChannelEnable;
	reg [1:0] rOutLevel;
	reg [3:0] rStep;
	reg [3:0] rStepScaled;
 	wire [4:0] up_value, down_value;
 	reg [4:0] rWaveRamIndex;
	reg rWaveRamHnL;
	reg [7:0] iWaveRam [0:31]; 
	always @ (posedge iClock) begin
		if (iReset) begin
			iWaveRam[0]=8'h01;
			iWaveRam[1]=8'h23;
			iWaveRam[2]=8'h45;
			iWaveRam[3]=8'h67;
			iWaveRam[4]=8'h89;
			iWaveRam[5]=8'hAB;
			iWaveRam[6]=8'hCD;
			iWaveRam[7]=8'hEF;
			iWaveRam[8]=8'hED;
			iWaveRam[9]=8'hCB;
			iWaveRam[10]=8'hA9;
			iWaveRam[11]=8'h87;
			iWaveRam[12]=8'h65;
			iWaveRam[13]=8'h43;
			iWaveRam[14]=8'h21;
			iWaveRam[15]=8'h00;
			iWaveRam[16]=8'h01;
			iWaveRam[17]=8'h23;
			iWaveRam[18]=8'h45;
			iWaveRam[19]=8'h67;
			iWaveRam[20]=8'h89;
			iWaveRam[21]=8'hAB;
			iWaveRam[22]=8'hCD;
			iWaveRam[23]=8'hEF;
			iWaveRam[24]=8'hED;
			iWaveRam[25]=8'hCB;
			iWaveRam[26]=8'hA9;
			iWaveRam[27]=8'h87;
			iWaveRam[28]=8'h65;
			iWaveRam[29]=8'h43;
			iWaveRam[30]=8'h21;
			iWaveRam[31]=8'h00;
		end
	end
	always @(posedge iClock) begin
		if (iReset || iNR34[7]) begin 
			rChannelEnable	<= iNR30[7];
			rLength 		<= iNR31[7:0];
			rLengthCounter 	<= 256 - iNR31[7:0]; 	
			rLengthComplete <= 0;			
			rTimedMode 		<= iNR34[6];
			rOutLevel		<= iNR32[6:5];
			rStep			<= iWaveRam[0][3:0];
			rWaveRamIndex	<= 0;
			rWaveRamHnL		<= 1; 
			rTone 			<= 0;
			rSoundFrequency[10:0] <= 2048-{iNR34[2:0],iNR33[7:0]};
			rSoundFrequencyCounter <= 2048-{iNR34[2:0],iNR33[7:0]}; 
		end
	end
	always @ (posedge rTone) begin
		if (rChannelEnable) begin
			if (~rWaveRamHnL) begin	
				rStep <= iWaveRam[rWaveRamIndex][7:4];
				rWaveRamHnL <= ~rWaveRamHnL;
			end
			else begin
				rStep <= iWaveRam[rWaveRamIndex][3:0];
				rWaveRamHnL <= ~rWaveRamHnL;
				if (rWaveRamIndex == 5'd31) begin
					rWaveRamIndex <= rWaveRamIndex+1;
					rLengthComplete <= rTimedMode;			
				end
				else begin
					rWaveRamIndex <= rWaveRamIndex+1;
				end
			end
		end
		else begin
			rStep <= 4'b0;
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
	always @(posedge iOsc256) begin
		if (rLengthCounter == 0) begin
			rLengthCounter <= 256-rLength;
			rLengthComplete <= rTimedMode; 
		end
		else begin
			rLengthCounter <= rLengthCounter-1;
		end
	end
	assign up_value = 5'd15 + rStepScaled;
	assign down_value = 5'd15 - rStepScaled;
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
	always @ (rOutLevel or rStep) begin
		case (rOutLevel[1:0])
			2'd0: rStepScaled = 0;
			2'd1: rStepScaled = rStep;
			2'd2: rStepScaled = rStep >> 1;
			2'd3: rStepScaled = rStep >> 2;
		endcase
	end
assign oOnFlag = rLengthComplete;
endmodule