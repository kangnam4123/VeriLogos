module p_SSYNC3DO_C_PPP (
  clk
 ,d
 ,clr_
 ,q
 );
input clk ;
input d ;
input clr_ ;
output q ;
reg q,d1,d0;
always @(posedge clk or negedge clr_)
begin
    if(~clr_)
        {q,d1,d0} <= 3'd0;
    else
        {q,d1,d0} <= {d1,d0,d};
end
endmodule