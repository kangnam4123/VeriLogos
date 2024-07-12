module WR_ALIGNER ( PACKET, DP_Q, SIZE, WRDATA, ENBYTE );
	input	 [3:0]	PACKET;	
	input	[63:0]	DP_Q;
	input	 [1:0]	SIZE;
	output	[31:0]	WRDATA;
	output	 [3:0]	ENBYTE;
	reg		 [3:0]	ENBYTE;
	reg		 [7:0]	dbyte0,dbyte1,dbyte2,dbyte3;
	wire			switch;
	assign switch = (SIZE == 2'b11) & (PACKET[3:2] == 2'b00);
	always @(DP_Q or switch or PACKET)
		case (PACKET[1:0])
		  2'b00 : dbyte0 =    switch ?   DP_Q[7:0] : DP_Q[39:32];
		  2'b01 : dbyte0 = PACKET[3] ? DP_Q[63:56] : DP_Q[31:24];
		  2'b10 : dbyte0 = PACKET[3] ? DP_Q[55:48] : DP_Q[23:16];
		  2'b11 : dbyte0 = PACKET[3] ? DP_Q[47:40] :  DP_Q[15:8];
		endcase
	always @(DP_Q or switch or PACKET)
		case (PACKET[1:0])
		  2'b00 : dbyte1 =    switch ?  DP_Q[15:8] : DP_Q[47:40];
		  2'b01 : dbyte1 =    switch ?   DP_Q[7:0] : DP_Q[39:32];
		  2'b10 : dbyte1 = PACKET[3] ? DP_Q[63:56] : DP_Q[31:24];
		  2'b11 : dbyte1 = PACKET[3] ? DP_Q[55:48] : DP_Q[23:16];
		endcase
	always @(DP_Q or switch or PACKET)
		case (PACKET[1:0])
		  2'b00 : dbyte2 =    switch ? DP_Q[23:16] : DP_Q[55:48];
		  2'b01 : dbyte2 =    switch ?  DP_Q[15:8] : DP_Q[47:40];
		  2'b10 : dbyte2 =    switch ?   DP_Q[7:0] : DP_Q[39:32];
		  2'b11 : dbyte2 = PACKET[3] ? DP_Q[63:56] : DP_Q[31:24];
		endcase
	always @(DP_Q or switch or PACKET)
		case (PACKET[1:0])
		  2'b00 : dbyte3 =    switch ? DP_Q[31:24] : DP_Q[63:56];
		  2'b01 : dbyte3 =    switch ? DP_Q[23:16] : DP_Q[55:48];
		  2'b10 : dbyte3 =    switch ?  DP_Q[15:8] : DP_Q[47:40];
		  2'b11 : dbyte3 =    switch ?   DP_Q[7:0] : DP_Q[39:32];
		endcase
	assign WRDATA = {dbyte3,dbyte2,dbyte1,dbyte0};
	always @(SIZE or PACKET)
		casex ({SIZE,PACKET})
		  6'b00_xx_00 : ENBYTE = 4'b0001;	
		  6'b00_xx_01 : ENBYTE = 4'b0010;
		  6'b00_xx_10 : ENBYTE = 4'b0100;
		  6'b00_xx_11 : ENBYTE = 4'b1000;
		  6'b01_xx_00 : ENBYTE = 4'b0011;	
		  6'b01_xx_01 : ENBYTE = 4'b0110;
		  6'b01_xx_10 : ENBYTE = 4'b1100;
		  6'b01_0x_11 : ENBYTE = 4'b1000;
		  6'b01_1x_11 : ENBYTE = 4'b0001;
		  6'b11_xx_00 : ENBYTE = 4'b1111;	
		  6'b11_00_01 : ENBYTE = 4'b1110;
		  6'b11_01_01 : ENBYTE = 4'b1111;
		  6'b11_1x_01 : ENBYTE = 4'b0001;
		  6'b11_00_10 : ENBYTE = 4'b1100;
		  6'b11_01_10 : ENBYTE = 4'b1111;
		  6'b11_1x_10 : ENBYTE = 4'b0011;
		  6'b11_00_11 : ENBYTE = 4'b1000;
		  6'b11_01_11 : ENBYTE = 4'b1111;
		  6'b11_1x_11 : ENBYTE = 4'b0111;
		  6'b10_xx_00 : ENBYTE = 4'b1111;	
		  6'b10_0x_01 : ENBYTE = 4'b1110;
		  6'b10_1x_01 : ENBYTE = 4'b0001;
		  6'b10_0x_10 : ENBYTE = 4'b1100;
		  6'b10_1x_10 : ENBYTE = 4'b0011;
		  6'b10_0x_11 : ENBYTE = 4'b1000;
		  6'b10_1x_11 : ENBYTE = 4'b0111;
		endcase
endmodule