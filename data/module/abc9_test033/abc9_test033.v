module abc9_test033(input clk, d, r, output reg q);
always @(negedge clk or posedge r)
    if (r) q <= 1'b1;
    else q <= d;
endmodule