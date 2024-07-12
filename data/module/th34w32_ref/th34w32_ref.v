module th34w32_ref (y,a,b,c,d);
 output y;
 input a;
 input b;
 input c;
 input d;
 reg yi;
  always @(a or b or c or d) begin
   if (((a) | (b&c) | (b&d))) 
    begin
      yi <=  1;
    end
    else if (((a==0) & (b==0) & (c==0) & (d==0))) 
    begin
      yi <=  0;
    end
   end
  assign #1 y = yi; 
endmodule