module unpack_m2n (
        clk     ,   
        nrst    ,   
        start   ,   
        din     ,   
        vin     ,   
        dout    ,   
        vout    ,   
        remain  ,   
        last    ,   
        done        
        ) ;
parameter               BITM = 40 ;
parameter               BITN = 8 ;
parameter               LW = 6 ;
input                   clk ;
input                   nrst ;
input                   start ;
input   [BITM-1 :0]     din ;
input                   vin ;
input   [LW -1:0]       remain ;
input                   last ;
output  [BITN-1 :0]     dout ;
output                  vout ;
output                  done ;
reg     [BITM + BITN -1 :0]     sreg ;
wire    [BITM + BITN -1 :0]     sreg_next ;
reg     [LW -1 : 0]             cnt ;
wire                            rd ;
wire    [BITN-1 :0]             data ;
wire    [BITM + BITN -1 :0]     tmp ;
wire    [BITM + BITN -1 :0]     tmp2 ;
wire    [LW -1 : 0]             shift ;
reg                             last_i ;
reg                             last_byte_s0 ;
wire                            last_byte ;
assign dout = data ;
assign vout = rd ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    cnt <= 0 ;
  else if (start)
    cnt <= 0 ;
  else if (vin)
  begin
    if (~last)
      cnt <= cnt + BITM ;
    else
      cnt <= cnt + remain ;
  end
  else if (rd)
    cnt <= cnt - BITN ;
assign rd = cnt >= BITN ;
assign data = sreg [BITM + BITN -1 : BITM] ;
assign tmp = {{BITM{1'b0}}, din} ;
assign shift = BITN - cnt ;
assign tmp2 = (tmp << shift) | sreg ;
assign sreg_next = vin ? tmp2 : rd ? {sreg[BITM -1 : 0], {BITN{1'b0}}} : sreg ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    sreg <= 0 ;
  else if (start)
    sreg <= 0 ;
  else 
    sreg <= sreg_next ;
always @ (posedge clk or negedge nrst)
  if (~nrst)
    last_i <= 1'b0 ;
  else if (start)
    last_i <= 1'b0 ;
  else if (vin & last)
    last_i <= 1'b1 ;
assign last_byte = last_i && cnt < BITN ;
always @ (posedge clk)
  last_byte_s0 <= last_byte ;
assign done = ~last_byte_s0 & last_byte ;
endmodule