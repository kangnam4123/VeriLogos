module abc9_test031(input clk1, clk2, d, output reg q1, q2);
always @(posedge clk1) q1 <= d;
always @(negedge clk2) q2 <= q1;
endmodule