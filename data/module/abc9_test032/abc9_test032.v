module abc9_test032(input clk, d, r, output reg q);
always @(posedge clk or posedge r)
    if (r) q <= 1'b0;
    else q <= d;
endmodule