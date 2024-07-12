module smdblc_6_128 ( PIN, GIN, POUT, GOUT );
   input  [63:0] PIN;
   input  [63:0] GIN;
   output [0:0] POUT;
   output [63:0] GOUT;
   assign GOUT[63:0] = GIN[63:0];
endmodule