module breathingled (
  clk,
  reset_,
  led
  );
  input clk;
  input reset_;
  output [7:0] led;
  reg [18:0] next_ctr;            
  reg [6:0] duty_ctr;             
  reg [6:0] duty_cycle;           
  reg inhale;                     
  reg led_state;                  
  assign led = {8{led_state}};    
  assign next = &next_ctr;        
  always@ (posedge clk or negedge reset_)
    if (!reset_)
      next_ctr <= 19'd0;
    else
      next_ctr <= next_ctr + 19'd1;
  always@ (posedge clk or negedge reset_)
    if (!reset_)
      duty_cycle <= 7'd0;
    else if (next)
      duty_cycle <= duty_cycle + 7'd1;
  always@ (posedge clk or negedge reset_)
    if (!reset_)
      duty_ctr <= 7'd0;
    else
      duty_ctr <= duty_ctr + 7'd1;
  always@ (posedge clk or negedge reset_)
    if (!reset_)
      inhale <= 1'b0;
    else if (next && &duty_cycle)
      inhale <= ~inhale;
  always@ (posedge clk or negedge reset_)
    if (!reset_)
      led_state <= 1'b0;
    else if (inhale)
      led_state <= (duty_ctr < duty_cycle);
    else
      led_state <= (duty_ctr > duty_cycle);
endmodule