module Test_26 (clk, Value, Result);
   input clk;
   input Value;
   output Result;
   reg Internal;
   assign Result = Internal ^ clk;
   always @(posedge clk)
     Internal <= #1 Value;
endmodule