module uart_sync_flops_1
(
  rst_i,
  clk_i,
  stage1_rst_i,
  stage1_clk_en_i,
  async_dat_i,
  sync_dat_o
);
parameter width         = 1;
parameter init_value    = 1'b0;
input                           rst_i;                  
input                           clk_i;                  
input                           stage1_rst_i;           
input                           stage1_clk_en_i;        
input   [width-1:0]             async_dat_i;            
output  [width-1:0]             sync_dat_o;             
reg     [width-1:0]             sync_dat_o;
reg     [width-1:0]             flop_0;
always @ (posedge clk_i or posedge rst_i)
begin
    if (rst_i)
        flop_0 <= {width{init_value}};
    else
        flop_0 <= async_dat_i;    
end
always @ (posedge clk_i or posedge rst_i)
begin
    if (rst_i)
        sync_dat_o <= {width{init_value}};
    else if (stage1_rst_i)
        sync_dat_o <= {width{init_value}};
    else if (stage1_clk_en_i)
        sync_dat_o <= flop_0;       
end
endmodule