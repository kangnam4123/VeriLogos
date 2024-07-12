module halt (input clk,
             input rst,
             input [31:0] addr_b,
             input [31:0] data_b_in,
             input [31:0] data_b_we,
             output reg   FINISH);
   always @(posedge clk)
     if(~rst) FINISH <= 0;
     else
        begin
           if (addr_b == 65541)
             FINISH <= 1;
        end
endmodule