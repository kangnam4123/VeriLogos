module add2_1(sum,x,y,clk);
  output reg sum;
  input x,y,clk;
  reg t1,t2;
  always @(posedge clk) begin
      sum <= x + y;
  end
endmodule