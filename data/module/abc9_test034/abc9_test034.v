module abc9_test034(input clk, d, output reg q1, q2);
always @(posedge clk) q1 <= d;
always @(posedge clk) q2 <= q1;
endmodule