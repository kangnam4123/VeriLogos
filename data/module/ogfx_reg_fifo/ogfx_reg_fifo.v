module  ogfx_reg_fifo (
    fifo_cnt_o,                          
    fifo_empty_cnt_o,                    
    fifo_data_o,                         
    fifo_done_evt_o,                     
    fifo_empty_o,                        
    fifo_full_o,                         
    fifo_ovfl_evt_o,                     
    mclk,                                
    puc_rst,                             
    fifo_data_i,                         
    fifo_enable_i,                       
    fifo_pop_i,                          
    fifo_push_i                          
);
output         [3:0] fifo_cnt_o;         
output         [3:0] fifo_empty_cnt_o;   
output        [15:0] fifo_data_o;        
output               fifo_done_evt_o;    
output               fifo_empty_o;       
output               fifo_full_o;        
output               fifo_ovfl_evt_o;    
input                mclk;               
input                puc_rst;            
input         [15:0] fifo_data_i;        
input                fifo_enable_i;      
input                fifo_pop_i;         
input                fifo_push_i;        
parameter    FIFO_EMPTY        =  4'h0,
             FIFO_FULL         =  4'hf;
reg    [3:0] fifo_cnt_o;
wire   [3:0] fifo_cnt_nxt;
assign    fifo_full_o        =  (fifo_cnt_o == FIFO_FULL);
assign    fifo_empty_o       =  (fifo_cnt_o == FIFO_EMPTY);
assign    fifo_empty_cnt_o   =  (FIFO_FULL-fifo_cnt_o);
wire      fifo_push_int      =  fifo_push_i & !fifo_full_o;
wire      fifo_pop_int       =  fifo_pop_i  & !fifo_empty_o;
assign    fifo_done_evt_o = ~fifo_empty_o & (fifo_cnt_nxt == FIFO_EMPTY);
assign    fifo_ovfl_evt_o =  fifo_push_i  &  fifo_full_o;
assign fifo_cnt_nxt = ~fifo_enable_i                 ?  FIFO_EMPTY        : 
                      (fifo_push_int & fifo_pop_int) ?  fifo_cnt_o        : 
                       fifo_push_int                 ?  fifo_cnt_o + 3'h1 : 
                       fifo_pop_int                  ?  fifo_cnt_o - 3'h1 : 
                                                        fifo_cnt_o;         
always @(posedge mclk or posedge puc_rst)
  if (puc_rst) fifo_cnt_o <= FIFO_EMPTY;
  else         fifo_cnt_o <= fifo_cnt_nxt;
reg [3:0] wr_ptr;
always @(posedge mclk or posedge puc_rst)
  if (puc_rst)                    wr_ptr  <=  4'h0;
  else if (~fifo_enable_i)        wr_ptr  <=  4'h0;
  else if (fifo_push_int)
    begin
       if (wr_ptr==(FIFO_FULL-1)) wr_ptr  <=  4'h0;
       else                       wr_ptr  <=  wr_ptr + 4'h1;
    end
reg [15:0] fifo_mem [0:15];
always @(posedge mclk or posedge puc_rst)
  if (puc_rst)
    begin
       fifo_mem[0]      <=  16'h0000;
       fifo_mem[1]      <=  16'h0000;
       fifo_mem[2]      <=  16'h0000;
       fifo_mem[3]      <=  16'h0000;
       fifo_mem[4]      <=  16'h0000;
       fifo_mem[5]      <=  16'h0000;
       fifo_mem[6]      <=  16'h0000;
       fifo_mem[7]      <=  16'h0000;
       fifo_mem[8]      <=  16'h0000;
       fifo_mem[9]      <=  16'h0000;
       fifo_mem[10]     <=  16'h0000;
       fifo_mem[11]     <=  16'h0000;
       fifo_mem[12]     <=  16'h0000;
       fifo_mem[13]     <=  16'h0000;
       fifo_mem[14]     <=  16'h0000;
       fifo_mem[15]     <=  16'h0000;
    end
  else if (fifo_push_int)
    begin
       fifo_mem[wr_ptr] <=  fifo_data_i;
    end
reg [3:0] rd_ptr;
always @(posedge mclk or posedge puc_rst)
  if (puc_rst)                    rd_ptr  <=  4'h0;
  else if (~fifo_enable_i)        rd_ptr  <=  4'h0;
  else if (fifo_pop_int)
    begin
       if (rd_ptr==(FIFO_FULL-1)) rd_ptr  <=  4'h0;
       else                       rd_ptr  <=  rd_ptr + 4'h1;
    end
assign fifo_data_o = fifo_mem[rd_ptr];
endmodule