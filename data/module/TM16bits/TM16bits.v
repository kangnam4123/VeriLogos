module TM16bits
  #(
    parameter CNT_PRESC=24,
    parameter ENA_TMR=1
   )
   (
    input        wb_clk_i,  
    input        wb_rst_i,  
    input  [0:0] wb_adr_i,  
    output [7:0] wb_dat_o,  
    input  [7:0] wb_dat_i,  
    input        wb_we_i,   
    input        wb_stb_i,  
    output       wb_ack_o,  
    output reg   irq_req_o,
    input        irq_ack_i
   );
localparam integer CNT_BITS=$clog2(CNT_PRESC);
reg  [15:0] cnt_r=0;
reg  [15:0] div_r=0;
wire tc; 
wire ena_cnt;
reg  [CNT_BITS-1:0] pre_cnt_r;
always @(posedge wb_clk_i)
begin : tmr_source
  if (wb_rst_i)
     pre_cnt_r <= 0;
  else
     begin
     pre_cnt_r <= pre_cnt_r+1;
     if (pre_cnt_r==CNT_PRESC-1)
        pre_cnt_r <= 0;
     end
end 
assign ena_cnt=pre_cnt_r==CNT_PRESC-1;
always @(posedge wb_clk_i)
begin : do_count
  if (wb_rst_i || tc || (wb_stb_i && wb_we_i))
     cnt_r <= 0;
  else
     if (ena_cnt)
        cnt_r <= cnt_r+1;
end 
assign tc=cnt_r==div_r-1 && ena_cnt;
always @(posedge wb_clk_i)
begin : do_flag
  if (wb_rst_i)
     irq_req_o <= 0;
  else if (tc && ENA_TMR)
     irq_req_o <= 1;
  else if (irq_ack_i)
     irq_req_o <= 0;
end 
assign wb_dat_o=0;
assign wb_ack_o=wb_stb_i;
always @(posedge wb_clk_i)
begin : do_write_div
  if (wb_rst_i)
     div_r <= 0;
  else if (wb_stb_i && wb_we_i)
     begin
     if (wb_adr_i)
        div_r[15:8] <= wb_dat_i;
     else
        div_r[7:0]  <= wb_dat_i;
     end
end 
endmodule