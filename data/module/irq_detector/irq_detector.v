module irq_detector #(
parameter INTR_TYPE = 1'b1
)(
   clk,
	reset_n,
	irq,
	counter_start,
	counter_stop
);
input   wire  clk;
input   wire  irq;
input   wire  reset_n;
output  wire  counter_start;
output  wire  counter_stop;
reg irq_d;
always @ (posedge clk or negedge reset_n)
   if (~reset_n) begin
        irq_d <= 1'b0;
   end
   else begin
	     irq_d <= irq;
   end
generate
if (INTR_TYPE == 1'b0) begin	
 assign counter_stop = ~irq & irq_d;
 assign counter_start = irq & ~irq_d;
end else begin
  assign counter_start = irq & ~irq_d;
  assign counter_stop = 1'b0;
end
endgenerate
endmodule