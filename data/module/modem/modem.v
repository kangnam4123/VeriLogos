module modem #(parameter WB_DAT_WIDTH = 8)
   (
    input reset,
    input clk,
    output [WB_DAT_WIDTH-1:0] msr, 
    input [1:0] mcr, 
    input msr_rd, 
    input dcd_n, 
    input cts_n, 
    input dsr_n, 
    input ri_n, 
    output dtr_n, 
    output rts_n 
    );
   reg [WB_DAT_WIDTH-1:0] msr_reg;
   reg 			  ctsn_d1;
   reg 			  dsrn_d1;
   reg 			  dcdn_d1;
   reg 			  rin_d1;
   assign dtr_n = ~mcr[0];
   assign rts_n = ~mcr[1];
   assign msr = msr_reg;
   always @(posedge clk or posedge reset)  begin
      if (reset) begin
         msr_reg <= 0;
         ctsn_d1 <= 1'b1;
         dsrn_d1 <= 1'b1;
         dcdn_d1 <= 1'b1;
         rin_d1  <= 1'b1;
        end
      else  begin
         ctsn_d1 <= cts_n;
         dsrn_d1 <= dsr_n;
         dcdn_d1 <= dcd_n;
         rin_d1  <= ri_n ;
         if (msr_rd) 
           msr_reg <= 0;
         else begin
            msr_reg[0] <= msr_reg[0] | (ctsn_d1 ^ cts_n); 
            msr_reg[1] <= msr_reg[1] | (dsrn_d1 ^ dsr_n); 
            msr_reg[2] <= msr_reg[2] | (~rin_d1 & ri_n ); 
            msr_reg[3] <= msr_reg[3] | (dcdn_d1 ^ dcd_n); 
            msr_reg[4] <= !cts_n;  
            msr_reg[5] <= !dsr_n;  
            msr_reg[6] <= !ri_n ;  
            msr_reg[7] <= !dcd_n;  
         end
      end
   end
endmodule