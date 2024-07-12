module abc9_test035(input clk, d, output reg [1:0] q);
always @(posedge clk) q[0] <= d;
always @(negedge clk) q[1] <= q[0];
endmodule