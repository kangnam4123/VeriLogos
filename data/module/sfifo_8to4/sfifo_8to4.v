module sfifo_8to4 (
        clk         ,   
        ce          ,   
        nrst        ,   
        reset       ,   
        din         ,   
        dout        ,   
        rd          ,   
        wr          ,   
        full        ,   
        empty       ,   
        nsin        ,   
        nsout           
        ) ;
input           clk ;
input           ce ;
input           nrst ;
input           reset ;
input   [7:0]   din ;
output  [3:0]   dout ;
input           rd ;
input           wr ;
output          full ;
output          empty ;
input   [3:0]   nsin ;
input   [3:0]   nsout ;
reg     [15:0]  buffer ;
reg     [4:0]   cnt ;
wire    [19:0]  shift_out ;
wire    [23:0]  shift_in ;
wire    [4:0]   space_left ;
assign full = (cnt + nsin) > 16 ;
assign empty = cnt < nsout ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (ce)
  begin
    if (reset)
      cnt <= 0 ;
    else
    begin
      if (wr & rd)
        cnt <= cnt +nsin -nsout ;
      if (wr & ~rd)
        cnt <= cnt +nsin ;
      if (~wr & rd)
        cnt <= cnt -nsout ;
    end
  end
assign shift_out = {4'h0, buffer} << nsout ;  
assign dout = shift_out [19:16] ; 
assign space_left = rd ? 16 -cnt + nsout : 16 -cnt ;  
assign shift_in = {16'h0, din} << space_left ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    buffer <= 0 ;
  else if (ce)
  begin
    if (reset)
      buffer <= 0 ;
    else
    begin
      if (wr & rd)
        buffer <= shift_out [15:0] | shift_in [23:8] ;
      if (wr & ~rd)
        buffer <= buffer | shift_in [23:8] ;
      if (~wr & rd)
        buffer <= shift_out [15:0] ;
    end
  end  
endmodule