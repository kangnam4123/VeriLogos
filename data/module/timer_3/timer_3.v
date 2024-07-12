module timer_3 (
   timer_interrupt,
   clk, timer_count, timer_enable, timer_interrupt_clear
   ) ;
   input clk;
   input [31:0] timer_count;
   input        timer_enable;
   input        timer_interrupt_clear;   
   output       timer_interrupt;
   reg [31:0]   count = 32'h0000_0000;
   reg          timer_interrupt = 1'b0;
   reg          interrupt = 1'b0;
   assign timer_expired = (count >= timer_count);
   always @(posedge clk)
     if (timer_enable  && !timer_expired) begin
        count <= count + 1;        
     end else begin
        count <= 32'h0000_0000;        
     end
   always @(posedge clk)
     if (timer_enable  & !timer_interrupt_clear) begin
        interrupt <= timer_expired;        
     end else begin
        interrupt <= 1'b0;        
     end
endmodule