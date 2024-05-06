module p_SSYNC3DO (
  clk
 ,d
 ,q
 );
input clk ;
input d ;
output q ;
reg q, d1, d0;
always @(posedge clk)
begin
    {q,d1,d0} <= {d1,d0,d};
end
endmodule