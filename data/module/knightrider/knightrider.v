module knightrider (
    clk,
    reset_,
    led);
   input   clk;
   input   reset_;
   output  [7:0] led;
   reg [20:0] count;
   reg [7:0]  led;
   reg         left_shift;
   assign shift = count == 21'h1FFFFF;
   always@ (posedge clk or negedge reset_)
     if (!reset_)
       count <= 21'h0;
     else
       count <= count + 1;
   always@ (posedge clk or negedge reset_)
     if (!reset_)
       led[7:0] <= 8'b1000_0000;
     else if (shift && left_shift)    
       led[7:0] <= led[7:0] << 1;
     else if (shift)                  
       led[7:0] <= led[7:0] >> 1;
   always@ (posedge clk or negedge reset_)
     if (!reset_)
       left_shift <= 1'b0;
     else if (led[7:0] == 8'b1000_0000)
       left_shift <= 1'b0;
     else if (led[7:0] == 8'b0000_0001)
       left_shift <= 1'b1;
endmodule