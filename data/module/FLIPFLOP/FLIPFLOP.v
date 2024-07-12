module FLIPFLOP ( DIN, RST, CLK, DOUT );
input  DIN;
input  RST;
input  CLK;
output DOUT;
   reg DOUT_reg;
   always @ ( posedge RST or posedge CLK ) begin
      if (RST)
        DOUT_reg <= 1'b0;
      else
        DOUT_reg <= #1 DIN;
   end
   assign DOUT = DOUT_reg;
endmodule