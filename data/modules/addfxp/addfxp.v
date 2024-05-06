module addfxp(a, b, q, clk);
   parameter width = 16;
   input [width-1:0]  a, b; 
   input                     clk;
   output [width-1:0] q; 
   reg [width-1:0]    res; 
   assign                    q = res[0];
   integer                   i;
   always @(posedge clk) begin
     res[0] <= a+b;
   end
endmodule