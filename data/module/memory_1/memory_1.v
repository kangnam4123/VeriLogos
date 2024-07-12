module memory_1 (clk);
   input clk;
   parameter words = 16384, bits = 72;
   reg [bits-1 :0] mem[words-1 : 0];
endmodule