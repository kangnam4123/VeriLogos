module speed_select(
    input clk,rst_n,bps_start,
    output clk_bps
    );
    reg[13:0] cnt;
    reg clk_bps_r;
    reg[2:0] uart_ctrl;
    always @(posedge clk or negedge rst_n)
     if(!rst_n)
      cnt<=14'd0;
     else if((cnt==5207)|| !bps_start)
      cnt<=14'd0;
     else
      cnt<=cnt+1'b1;
    always @(posedge clk or negedge rst_n) begin
     if(!rst_n)
      clk_bps_r<=1'b0;
     else if(cnt==2603)
      clk_bps_r<=1'b1;
     else
      clk_bps_r<=1'b0;
    end
    assign clk_bps = clk_bps_r;
endmodule