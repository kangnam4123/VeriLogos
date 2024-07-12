module bt (
           out,
           in
           );
   input [7:0]  in;
   output [7:0] out;
   wire [7:0]   out = ~in;
endmodule