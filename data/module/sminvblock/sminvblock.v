module sminvblock ( GIN, GOUT );
   input  GIN;
   output GOUT;
   assign GOUT = ~ GIN;
endmodule