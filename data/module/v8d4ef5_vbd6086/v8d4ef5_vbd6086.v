module v8d4ef5_vbd6086 #(
 parameter M = 0
) (
 input clk,
 input rst,
 input cnt,
 output [15:0] q,
 output ov
);
 localparam N = 16; 
 reg [N:0] qi = 0;
 always @(posedge clk)
   if (rst | ov)
     qi <= 0;
   else
     if (cnt)
       qi <= qi + 1;
 assign q = qi;
 assign ov = (qi == M);
endmodule