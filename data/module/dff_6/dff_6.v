module dff_6 #(parameter W=1)
   (input wire[W-1:0] D, input clk, output reg[W-1:0] Q);
   always @(posedge clk)
     Q <= D;
endmodule