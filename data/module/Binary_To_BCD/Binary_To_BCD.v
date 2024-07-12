module Binary_To_BCD(
		CLK,
		RST,
		START,
		BIN,
		BCDOUT
);
   input            CLK;		
   input            RST;		
   input            START;		
   input [8:0]      BIN;		
   output [15:0]     BCDOUT;		
   reg [15:0] BCDOUT;
   reg [4:0]        shiftCount;
   reg [27:0]       tmpSR;
   parameter [2:0]  state_type_Idle = 0,
                    state_type_Init = 1,
                    state_type_Shift = 2,
                    state_type_Check = 3,
                    state_type_Done = 4;
   reg [2:0]        STATE;
   reg [2:0]        NSTATE;
   always @(posedge CLK or posedge RST)
   begin: STATE_REGISTER
      if (RST == 1'b1)
         STATE <= state_type_Idle;
      else 
         STATE <= NSTATE;
   end
   always @(posedge CLK or posedge RST)
   begin: OUTPUT_LOGIC
      if (RST == 1'b1) begin
         BCDOUT[11:0] <= 12'h000;
         tmpSR <= 28'h0000000;
      end      
      else
         case (STATE)
            state_type_Idle : begin
                  BCDOUT <= BCDOUT;				
                  tmpSR <= 28'h0000000;		
            end
            state_type_Init : begin
                  BCDOUT <= BCDOUT;										
                  tmpSR <= {19'b0000000000000000000, BIN};		
            end
            state_type_Shift : begin
                  BCDOUT <= BCDOUT;						
                  tmpSR <= {tmpSR[26:0], 1'b0};		
                  shiftCount <= shiftCount + 1'b1;	
            end
            state_type_Check : begin
                  BCDOUT <= BCDOUT;		
                  if (shiftCount != 4'hC)
                  begin
                     if (tmpSR[27:24] >= 4'h5)
                        tmpSR[27:24] <= tmpSR[27:24] + 4'h3;
                     if (tmpSR[23:20] >= 4'h5)
                        tmpSR[23:20] <= tmpSR[23:20] + 4'h3;
                     if (tmpSR[19:16] >= 4'h5)
                        tmpSR[19:16] <= tmpSR[19:16] + 4'h3;
                     if (tmpSR[15:12] >= 4'h5)
                        tmpSR[15:12] <= tmpSR[15:12] + 4'h3;
                  end
            end
            state_type_Done :
               begin
                  BCDOUT[11:0] <= tmpSR[23:12];		
                  tmpSR <= 28'h0000000;				
                  shiftCount <= 5'b00000;				
               end
         endcase
   end
   always @(START or shiftCount or STATE)
   begin: NEXT_STATE_LOGIC
      NSTATE <= state_type_Idle;
      case (STATE)
         state_type_Idle :
            if (START == 1'b1)
               NSTATE <= state_type_Init;
            else
               NSTATE <= state_type_Idle;
         state_type_Init :
            NSTATE <= state_type_Shift;
         state_type_Shift :
            NSTATE <= state_type_Check;
         state_type_Check :
            if (shiftCount != 4'hC)
               NSTATE <= state_type_Shift;
            else
               NSTATE <= state_type_Done;
         state_type_Done :
            NSTATE <= state_type_Idle;
         default : NSTATE <= state_type_Idle;
      endcase
   end
endmodule