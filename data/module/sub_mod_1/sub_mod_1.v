module sub_mod_1 (
   q, test_out,
   test_inout,
   data, clk, reset
   );
   input [7:0] data ;
   input       clk, reset;
   inout       test_inout;  
   output [7:0] q;
   output 	test_out;  
   logic [7:0] 	que;
   assign q = que;
   always @ ( posedge clk)
     if (~reset) begin
        que <= 8'b0;
     end else begin
        que <= data;
     end
endmodule