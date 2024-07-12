module Binary_To_BCD_1(
			CLK,
			RST,
			START,
			BIN,
			BCDOUT
	);
			input CLK;						
			input RST;						
			input START;					
			input [15:0] BIN;				
			output [15:0] BCDOUT;		
			reg [15:0] BCDOUT = 16'h0000;		
			reg [4:0] shiftCount = 5'd0;	   
			reg [31:0] tmpSR;						
			reg [2:0] STATE = Idle;				
			parameter [2:0] Idle = 3'b000,
								 Init = 3'b001,
								 Shift = 3'b011,
								 Check = 3'b010,
								 Done = 3'b110;
			always @(posedge CLK) begin
					if(RST == 1'b1) begin
							BCDOUT <= 16'h0000;
							tmpSR <= 31'h00000000;
							STATE <= Idle;
					end
					else begin
							case (STATE)
									Idle : begin
											BCDOUT <= BCDOUT;								 	
											tmpSR <= 32'h00000000;							
											if(START == 1'b1) begin
													STATE <= Init;
											end
											else begin
													STATE <= Idle;
											end
									end
									Init : begin
											BCDOUT <= BCDOUT;									
											tmpSR <= {16'b0000000000000000, BIN};	   
											STATE <= Shift;
									end
									Shift : begin
											BCDOUT <= BCDOUT;							
											tmpSR <= {tmpSR[30:0], 1'b0};			
											shiftCount <= shiftCount + 1'b1;		
											STATE <= Check;							
									end
									Check : begin
											BCDOUT <= BCDOUT;							
											if(shiftCount != 5'd16) begin
													if(tmpSR[31:28] >= 3'd5) begin
															tmpSR[31:28] <= tmpSR[31:28] + 2'd3;
													end
													if(tmpSR[27:24] >= 3'd5) begin
															tmpSR[27:24] <= tmpSR[27:24] + 2'd3;
													end
													if(tmpSR[23:20] >= 3'd5) begin
															tmpSR[23:20] <= tmpSR[23:20] + 2'd3;
													end
													if(tmpSR[19:16] >= 3'd5) begin
															tmpSR[19:16] <= tmpSR[19:16] + 2'd3;
													end
													STATE <= Shift;	
											end
											else begin
													STATE <= Done;
											end
									end
									Done : begin
											BCDOUT <= tmpSR[31:16];	
											tmpSR <= 32'h00000000;	
											shiftCount <= 5'b00000; 
											STATE <= Idle;
									end
							endcase
					end
			end
endmodule