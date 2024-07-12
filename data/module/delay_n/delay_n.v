module delay_n
  (
   input  clock,
   input  in,
   output out
   );
   parameter N = 2;
   reg [N-1:0] sreg = 0;
   assign out = sreg[N-1];
   always @ (posedge clock)
     sreg <= {sreg[N-2:0],in};
endmodule