module basiclatch ( clk, d, q);
input clk, d;
output q;
reg q;
always @ (clk or d)
  if(~clk)
    q = d;
endmodule