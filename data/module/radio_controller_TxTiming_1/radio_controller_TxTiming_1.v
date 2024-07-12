module radio_controller_TxTiming_1
(
	clk,
	reset,
	Tx_swEnable,
	TxGain_target,
	TxGain_rampGainStep,
	TxGain_rampTimeStep,
	dly_hwTxEn,
	dly_TxStart,
	dly_PowerAmpEn,
	dly_RampGain,
	hw_TxEn,
	hw_TxGain,
	hw_PAEn,
	hw_TxStart
);
	input			clk;
	input			reset;
	input			Tx_swEnable;
	input	[0:5]	TxGain_target;
	input	[0:3]	TxGain_rampGainStep;
	input	[0:3]	TxGain_rampTimeStep;
	input	[0:7]	dly_hwTxEn;
	input	[0:11]	dly_TxStart;
	input	[0:7]	dly_PowerAmpEn;
	input	[0:7]	dly_RampGain;
	output			hw_TxEn;
	output			hw_TxStart;
	output			hw_PAEn;
	output	[0:5]	hw_TxGain;
	reg		[0:7]	GainRamp_clockEn_counter;
	reg		[0:7]	timing_counter;
	reg		[0:11]	timing_counter_big;
	wire 	[0:6]	NewTxGain;
	reg  	[0:6]	TxGainBig;
	wire AutoGainRampEn;
	assign NewTxGain = ( (TxGainBig + TxGain_rampGainStep) > TxGain_target) ? TxGain_target : (TxGainBig + TxGain_rampGainStep);
	assign hw_TxGain = TxGainBig[1:6];
	assign hw_TxEn = (timing_counter > dly_hwTxEn) || dly_hwTxEn == 8'd254;
	assign hw_PAEn = (timing_counter > dly_PowerAmpEn) || dly_PowerAmpEn == 8'd254;
	assign hw_TxStart = (timing_counter_big > dly_TxStart) || dly_TxStart == 12'd4094;
	assign AutoGainRampEn = timing_counter > dly_RampGain;
	always @( posedge clk )
	begin
		if(reset | ~Tx_swEnable)
			TxGainBig <= 0;
		else if( AutoGainRampEn & (GainRamp_clockEn_counter==1))
			TxGainBig <= NewTxGain;
	end
	always @( posedge clk )
	begin
		if(reset | ~Tx_swEnable)
			timing_counter <= 0;
		else if(Tx_swEnable & timing_counter < 254)
			timing_counter <= timing_counter + 1;
	end
	always @( posedge clk )
	begin
		if(reset | ~Tx_swEnable)
			timing_counter_big <= 0;
		else if(Tx_swEnable & timing_counter_big < 4094)
			timing_counter_big <= timing_counter_big + 1;
	end
	always @( posedge clk )
	begin
		if(reset | GainRamp_clockEn_counter == TxGain_rampTimeStep)
			GainRamp_clockEn_counter <= 0;
		else
			GainRamp_clockEn_counter <= GainRamp_clockEn_counter + 1;
	end
endmodule