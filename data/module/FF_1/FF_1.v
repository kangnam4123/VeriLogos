module FF_1 (input d, clk, output reg q);
always @( posedge clk)
    q <= d;
endmodule