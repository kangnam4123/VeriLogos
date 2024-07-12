module lc_mbc_iso
  (
   MBC_ISOLATE,
   ADDROUT_uniso,	
   DATAOUT_uniso,	
   PENDOUT_uniso,	
   REQOUT_uniso,	
   PRIORITYOUT_uniso,	
   ACKOUT_uniso,	
   RESPOUT_uniso,	
   ADDROUT,		
   DATAOUT,		
   PENDOUT,		
   REQOUT, 		
   PRIORITYOUT,		
   ACKOUT,		
   RESPOUT,		
   LRC_SLEEP_uniso,
   LRC_RESET_uniso,
   LRC_ISOLATE_uniso,
   LRC_SLEEP,		
   LRC_RESET,		
   LRC_ISOLATE,		
   SLEEP_REQ_uniso,
   SLEEP_REQ		
   );
   input         MBC_ISOLATE;
   input [31:0]  ADDROUT_uniso;
   input [31:0]  DATAOUT_uniso;
   input 	 PENDOUT_uniso;
   input 	 REQOUT_uniso;
   input 	 PRIORITYOUT_uniso;
   input 	 ACKOUT_uniso;
   input 	 RESPOUT_uniso;
   output [31:0] ADDROUT;
   output [31:0] DATAOUT;
   output 	 PENDOUT;
   output 	 REQOUT;
   output 	 PRIORITYOUT;
   output 	 ACKOUT;
   output 	 RESPOUT;
   input 	 LRC_SLEEP_uniso;
   input 	 LRC_RESET_uniso;
   input 	 LRC_ISOLATE_uniso;
   output 	 LRC_SLEEP;
   output 	 LRC_RESET;
   output 	 LRC_ISOLATE;
   input 	 SLEEP_REQ_uniso;
   output 	 SLEEP_REQ;
   assign 	 ADDROUT     = ~LRC_ISOLATE & ADDROUT_uniso;
   assign 	 DATAOUT     = ~LRC_ISOLATE & DATAOUT_uniso;
   assign 	 PENDOUT     = ~LRC_ISOLATE & PENDOUT_uniso;
   assign 	 REQOUT      = ~LRC_ISOLATE & REQOUT_uniso;
   assign 	 PRIORITYOUT = ~LRC_ISOLATE & PRIORITYOUT_uniso;
   assign 	 ACKOUT      = ~LRC_ISOLATE & ACKOUT_uniso;
   assign 	 RESPOUT     = ~LRC_ISOLATE & RESPOUT_uniso;
   assign 	 LRC_SLEEP   =  MBC_ISOLATE | LRC_SLEEP_uniso;
   assign 	 LRC_RESET   =  MBC_ISOLATE | LRC_RESET_uniso;
   assign 	 LRC_ISOLATE =  MBC_ISOLATE | LRC_ISOLATE_uniso;
   assign 	 SLEEP_REQ   = ~MBC_ISOLATE & SLEEP_REQ_uniso;
endmodule