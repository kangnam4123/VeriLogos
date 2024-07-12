module asyn_fifo_write #(
    parameter                  ADDRWIDTH = 6,
    parameter   [ADDRWIDTH:0]  FIFODEPTH = 44,
    parameter   [ADDRWIDTH:0]  MINBIN2   = 0,
    parameter   [ADDRWIDTH:0]  MAXBIN2   = 7
) (
    input  wire                    w_clk    ,
    input  wire                    w_rst_n  ,
    input  wire                    w_en     ,
    input  wire [ADDRWIDTH:0]      r2w_ptr  ,
    output reg  [ADDRWIDTH-1:0]    wbin     ,
    output reg  [ADDRWIDTH:0]      wptr     ,
    output                         inc      ,
    output reg                     w_full   ,
    output reg  [ADDRWIDTH:0]      w_counter,
    output reg                     w_error
);
assign  inc  = w_en && !w_full;
reg  [ADDRWIDTH:0]  wbin2;
wire [ADDRWIDTH:0]  wbnext = (wbin2>=MINBIN2 && wbin2<MAXBIN2) ?
                             (wbin2 + 1'b1) : MINBIN2;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wbin2 <= MINBIN2;
    else if (inc)
        wbin2 <= wbnext;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wbin <= {ADDRWIDTH{1'b0}};
    else if (inc)
        wbin <= wbnext[ADDRWIDTH] ? wbnext[ADDRWIDTH-1:0] :
                    (wbnext[ADDRWIDTH-1:0] - MINBIN2[ADDRWIDTH-1:0]);
wire [ADDRWIDTH:0]  wptr_gray = {1'b0,wbnext[ADDRWIDTH:1]} ^ wbnext;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        wptr <= (MINBIN2>>1) ^ MINBIN2;
    else if (inc)
        wptr <= wptr_gray;
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
                              ) + inc;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        w_counter <= {(ADDRWIDTH+1){1'b0}};
    else
        w_counter <= distance;
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        w_full <= 1'b0;
    else
        w_full <= (distance == FIFODEPTH);
always @(posedge w_clk or negedge w_rst_n)
    if (!w_rst_n)
        w_error <= 1'b0;
    else
        w_error <= (w_counter > FIFODEPTH);
endmodule