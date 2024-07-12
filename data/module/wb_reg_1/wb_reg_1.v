module wb_reg_1
  #(parameter ADDR=0,
    parameter DEFAULT=0,
    parameter WIDTH=32)
   (input clk, input rst, 
    input [5:0] adr, input wr_acc,
    input [31:0] dat_i, output reg [WIDTH-1:0] dat_o);
   always @(posedge clk)
     if(rst)
       dat_o <= DEFAULT;
     else if(wr_acc & (adr == ADDR))
       dat_o <= dat_i[WIDTH-1:0];
endmodule