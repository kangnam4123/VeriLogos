module re_hz( 
input clock,
input resetn,
output outclock
);
reg [31:0] cnt;
always @( posedge clock or posedge resetn)  begin
  if( resetn == 1 )
    cnt = 0;
  else 
    cnt = cnt + 1;
end
  assign outclock = cnt[21];
endmodule