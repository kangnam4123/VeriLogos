module BUFT(inout wire TO, input wire D, input wire E, input wire CLK);
   reg save;
   assign TO = E? save : 2'bz;
   always @(posedge CLK)
     save <= D;
endmodule