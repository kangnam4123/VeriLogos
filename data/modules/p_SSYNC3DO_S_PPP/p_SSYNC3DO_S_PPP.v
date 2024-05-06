module p_SSYNC3DO_S_PPP (
  clk
 ,d
 ,set_
 ,q
 );
input clk ;
input d ;
input set_ ;
output q ;
reg q,d1,d0;
always @(posedge clk or negedge set_)
begin
    if(~set_)
        {q,d1,d0} <= 3'b111;
    else
        {q,d1,d0} <= {d1,d0,d};
end
endmodule