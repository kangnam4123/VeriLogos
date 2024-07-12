module stream_asyn_fifo_write #(
    parameter                  ADDRWIDTH  = 6,
    parameter   [ADDRWIDTH:0]  FIFODEPTH  = 44,
    parameter   [ADDRWIDTH:0]  HEADSIZE   = 0,
    parameter   [ADDRWIDTH:0]  MINBIN2    = 0,
    parameter   [ADDRWIDTH:0]  MAXBIN2    = 7
) (
    input  wire                    w_clk    ,
    input  wire                    w_rst_n  ,
    input  wire [2:0]              w_ctrl   ,  
    input  wire [ADDRWIDTH:0]      r2w_ptr  ,
    output reg  [ADDRWIDTH-1:0]    wbin     ,
    output      [ADDRWIDTH:0]      wptr     ,
    output                         inc      ,
    output reg                     w_full   ,
    output reg  [ADDRWIDTH:0]      w_counter,
    output reg                     w_error
);
localparam [2:0]
NOP         = 3'd0,
WRITE       = 3'd1,
EOF_WITH_WRITE    = 3'd2,
EOF_WITHOUT_WRITE = 3'd3,
HEAD        = 3'd4,
FINAL_HEAD  = 3'd5,
DISCARD     = 3'd6;
wire [2:0] w_ctrl_t = ( w_ctrl == DISCARD ) ? DISCARD :
                        w_full ? NOP : w_ctrl ;
assign  inc_t = ( w_ctrl_t == WRITE || w_ctrl_t == EOF_WITH_WRITE ) ;
assign  inc   =   inc_t || (w_ctrl_t == HEAD) || (w_ctrl_t == FINAL_HEAD) ;
wire  withouthead  =  ( HEADSIZE == { (ADDRWIDTH+1){1'b0} } ) ;
wire eofww  =  ( w_ctrl_t == EOF_WITH_WRITE ) ;
reg  eofww_d ;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        eofww_d <= 1'b0 ;
    else
        eofww_d <= eofww ;
wire fdwoh   =  ( withouthead &&
                  ( eofww_d || w_ctrl_t == EOF_WITHOUT_WRITE )
                );
wire fdwhead =  ( !withouthead &&
                  ( eofww || w_ctrl_t == EOF_WITHOUT_WRITE )
                );
reg  [ADDRWIDTH:0]  wbin2, wbin2_prev;
wire [ADDRWIDTH:0]  wbnext  = (wbin2>=MINBIN2 && wbin2<MAXBIN2) ?
                              (wbin2 + 1'b1) : MINBIN2;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wbin2 <= bin2add(MINBIN2);
    else if ( w_ctrl_t == DISCARD )     
        wbin2 <= bin2add(wbin2_prev);
    else if ( w_ctrl_t == FINAL_HEAD )  
        wbin2 <= bin2add(wbin2);
    else if ( inc_t )
        wbin2 <= wbnext;
reg  [ADDRWIDTH:0] wbin2_prev_t;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wbin2_prev_t <= MINBIN2;
    else if ( eofww_d || w_ctrl_t == EOF_WITHOUT_WRITE )
        wbin2_prev_t <= wbin2;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wbin2_prev <= MINBIN2;
    else if ( w_ctrl_t == FINAL_HEAD )  
        wbin2_prev <= ( eofww_d ? wbin2 : wbin2_prev_t ) ;
    else if ( fdwoh )                 
        wbin2_prev <= wbin2;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wbin <= HEADSIZE;
    else if ( w_ctrl_t == DISCARD )           
        wbin <= bin2tobin( bin2add(wbin2_prev) );
    else if ( fdwhead )                     
        wbin <= bin2tobin(wbin2_prev);
    else if ( w_ctrl_t == EOF_WITHOUT_WRITE
             || w_ctrl_t == FINAL_HEAD )      
        wbin <= bin2tobin( bin2add(wbin2) );
    else if ( inc_t || w_ctrl_t == HEAD )     
        wbin <= (wbin >= MAXBIN2[ADDRWIDTH-1:0]) ? {ADDRWIDTH{1'b0}} : (wbin + 1'b1);
assign  wptr = wbin2_prev;
reg [ADDRWIDTH:0] r2w_bin;
always @(r2w_ptr)
begin: GrayToBin
    integer i;
    for (i=ADDRWIDTH; i>=0; i=i-1)
        r2w_bin[i] = ^(r2w_ptr>>i);
end
wire [ADDRWIDTH:0] distance = ( (wbin2 >= r2w_bin) ?
                                (wbin2  - r2w_bin) :
                                (wbin2  - r2w_bin - (MINBIN2<<1) )
                              ) +
                              ( w_ctrl_t == FINAL_HEAD ? HEADSIZE : inc_t );
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        w_counter <= {(ADDRWIDTH+1){1'b0}};
    else
        w_counter <= distance;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        w_full <= 1'b0;
    else
        w_full <= (distance >= FIFODEPTH);
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        w_error <= 1'b0;
    else
        w_error <= (w_counter > (FIFODEPTH + HEADSIZE) );
function [ADDRWIDTH-1:0] bin2tobin;
input [ADDRWIDTH:0] b2;
begin
    bin2tobin =  b2[ADDRWIDTH] ? b2[ADDRWIDTH-1:0] :
                (b2[ADDRWIDTH-1:0] - MINBIN2[ADDRWIDTH-1:0]);
end
endfunction
function [ADDRWIDTH:0] bin2add;
input [ADDRWIDTH:0] b2;
reg   [ADDRWIDTH:0] sum;
begin
    sum = b2 + HEADSIZE;
    if (sum >= b2 && sum <= MAXBIN2)
        bin2add = sum;
    else
        bin2add = sum + MINBIN2 + (~MAXBIN2);
end
endfunction
endmodule