module v56885a_v3140f5 #(
 parameter SEG = 0
) (
 input clk,
 input start,
 output p,
 output tic
);
 localparam M = 12000000;
 localparam N = $clog2(M);
 wire rst_heart;
 wire ov_heart;
 wire ena;
 wire tic_heart;
 reg [N-1:0] heart=0;
 always @(posedge clk)
   if (rst_heart)
     heart <= 0;
   else
     heart <= heart + 1;
 assign ov_heart = (heart == M-1);
 assign tic_heart = ov_heart;
 assign rst_heart =~ena | ov_heart;
 reg [7:0] counter = 0;
 wire ov;
 wire rst;
 always @(posedge clk)
 if (rst)
   counter <= 0;
 else
   if (tic_heart)
     counter <= counter + 1;
 assign ov = (counter == SEG);
 reg q = 0;
 always @(posedge clk)
   if (start)
     q <= 1'b1;
   else if (rst)
     q<=1'b0;
 assign rst = ~q | ov | start;
 assign ena = ~rst;
 assign p = q;
 assign tic = ov;
endmodule