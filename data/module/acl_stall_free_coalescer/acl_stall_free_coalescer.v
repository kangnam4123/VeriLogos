module acl_stall_free_coalescer (
  clk,                        
  reset,                      
  i_valid,                    
  i_empty,                    
  i_addr,                     
  o_page_addr,                
  o_page_addr_valid,          
  o_num_burst,                
  o_new_page
);
parameter AW = 1,
          PAGE_AW = 1,
          MAX_BURST = 1,
          TIME_OUT = 1,
          MAX_THREAD = 1,
          CACHE_LAST = 0,
          DISABLE_COALESCE = 0;
localparam BURST_CNT_WIDTH = $clog2(MAX_BURST+1);
localparam TIME_OUT_W = $clog2(TIME_OUT+1);
localparam THREAD_W = $clog2(MAX_THREAD+1);
input clk;
input reset;
input i_valid;
input i_empty;
input [AW-1:0] i_addr;
output reg [PAGE_AW-1:0] o_page_addr;
output reg o_page_addr_valid;
output reg [BURST_CNT_WIDTH-1:0] o_num_burst;
output reg o_new_page;
logic init;
wire match_current_wire, match_next_wire, reset_cnt;
reg  [BURST_CNT_WIDTH-1:0] num_burst;
reg  valid_burst;
wire [PAGE_AW-1:0] page_addr;
reg  [PAGE_AW-1:0] R_page_addr = 0;
reg  [PAGE_AW-1:0] R_page_addr_next = 0;
reg  [PAGE_AW-1:0] addr_hold = 0;
reg  [3:0] delay_cnt; 
reg  [TIME_OUT_W-1:0] time_out_cnt = 0;
reg  [THREAD_W-1:0] thread_cnt = 0;
wire time_out;
wire max_thread;
assign page_addr = i_addr[AW-1:AW-PAGE_AW];                                       
assign match_current_wire = page_addr == R_page_addr;
assign max_thread = thread_cnt[THREAD_W-1] & i_empty;
assign time_out =  time_out_cnt[TIME_OUT_W-1] & i_empty;
assign reset_cnt = valid_burst & (
                   num_burst[BURST_CNT_WIDTH-1]     
                   | time_out
                   | max_thread
                   | !match_current_wire & !match_next_wire & !init & i_valid ); 
generate
if(MAX_BURST == 1) begin : BURST_ONE
  assign match_next_wire = 1'b0;
end
else begin : BURST_N
  assign match_next_wire = page_addr == R_page_addr_next & !init & i_valid & (|page_addr[BURST_CNT_WIDTH-2:0]);
end
if(DISABLE_COALESCE) begin : GEN_DISABLE_COALESCE
  always@(*) begin
    o_page_addr         = page_addr;
    o_page_addr_valid   = i_valid;
    o_num_burst         = 1;
    o_new_page          = 1'b1;
  end
end
else begin : ENABLE_COALESCE
  always@(posedge clk) begin
    if(i_valid) begin
      R_page_addr <= page_addr;
      R_page_addr_next <= page_addr + 1'b1;
    end
    o_num_burst <= num_burst;
    o_page_addr <= addr_hold;
    if(i_valid | reset_cnt) time_out_cnt <= 0;  
    else if(!time_out_cnt[TIME_OUT_W-1] & valid_burst) time_out_cnt <= time_out_cnt + 1;
    if(reset_cnt) thread_cnt <= i_valid;
    else if(i_valid & !thread_cnt[THREAD_W-1]) thread_cnt <= thread_cnt + 1;
    if(o_page_addr_valid) delay_cnt <= 1;
    else if(!delay_cnt[3]) delay_cnt <= delay_cnt + 1;
    if(reset_cnt) begin
      num_burst <= i_valid & !match_current_wire;
      addr_hold <= page_addr;
    end
    else if(i_valid) begin
      num_burst <= (!valid_burst & !match_current_wire | init)? 1 : num_burst + match_next_wire;
      if(!valid_burst | init) addr_hold <= page_addr;
    end
    o_new_page <= (!match_current_wire| init) & i_valid;
  end
  always@(posedge clk or posedge reset) begin
    if(reset) begin
      o_page_addr_valid <= 1'b0;
      valid_burst <= 1'b0;
    end
    else begin
      if(reset_cnt) valid_burst <= i_valid & !match_current_wire;
      else if(i_valid) begin
        if(!valid_burst & !match_current_wire | init) valid_burst <= 1'b1;
        else if(match_next_wire) valid_burst <= 1'b1;
      end
      o_page_addr_valid <= reset_cnt;
    end
  end
end
if(CACHE_LAST) begin : GEN_ENABLE_CACHE
  always@(posedge clk or posedge reset) begin
    if(reset) init <= 1'b1;
    else begin
      if(!valid_burst & !o_page_addr_valid & (!i_valid | match_current_wire & !init)) init <= 1'b1; 
      else if(i_valid) init <= 1'b0;
    end
  end
end
else begin : GEN_DISABLE_CACHE
  always@(posedge clk or posedge reset) begin
    if(reset) init <= 1'b1;
    else begin
      if(!valid_burst & delay_cnt[3] & !o_page_addr_valid & i_empty & (!i_valid | match_current_wire & !init)) init <= 1'b1; 
      else if(i_valid) init <= 1'b0;
    end
  end
end
endgenerate
endmodule