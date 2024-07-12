module B_1(
   y,
   b, c
   ); 
   input b, c;
   output reg y;
   always @(*) begin : myproc
      y = b ^ c;
   end
endmodule