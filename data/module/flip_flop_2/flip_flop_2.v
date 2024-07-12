module flip_flop_2(
    input d,
    output reg q,
    input clk
    );
    always @(posedge clk)
        q <= d;
endmodule