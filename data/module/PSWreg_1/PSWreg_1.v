module PSWreg_1 (
	rst, 
	clk, 
	unaligned, 
	ovf, 
	status);
   input rst;
   input clk;
   input unaligned;
   input ovf;
   output [31:0] status;
   assign status[31] = 1'b0 ;
   assign status[30] = 1'b0 ;
   assign status[29] = 1'b0 ;
   assign status[28] = 1'b0 ;
   assign status[27] = 1'b0 ;
   assign status[26] = 1'b0 ;
   assign status[25] = 1'b0 ;
   assign status[24] = 1'b0 ;
   assign status[23] = 1'b0 ;
   assign status[22] = 1'b0 ;
   assign status[21] = 1'b0 ;
   assign status[20] = 1'b0 ;
   assign status[19] = 1'b0 ;
   assign status[18] = 1'b0 ;
   assign status[17] = 1'b0 ;
   assign status[16] = 1'b0 ;
   assign status[15] = 1'b0 ;
   assign status[14] = 1'b0 ;
   assign status[13] = 1'b0 ;
   assign status[12] = 1'b0 ;
   assign status[11] = 1'b0 ;
   assign status[10] = 1'b0 ;
   assign status[9] = 1'b0 ;
   assign status[8] = 1'b0 ;
   assign status[7] = 1'b0 ;
   assign status[6] = 1'b0 ;
   assign status[5] = 1'b0 ;
   assign status[4] = 1'b0 ;
   assign status[3] = 1'b0 ;
   assign status[2] = 1'b0 ;
endmodule