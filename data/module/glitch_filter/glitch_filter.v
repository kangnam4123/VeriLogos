module glitch_filter(
    input clk, key_in,
    output key_out
);
    reg [21:0] count_low;
    reg [21:0] count_high;
    reg key_out_reg;
    always @(posedge clk)
        if(key_in ==1'b0)
            count_low <= count_low + 1;
        else
            count_low <= 0;
    always @(posedge clk)
        if(key_in ==1'b1)
            count_high <= count_high + 1;
        else
            count_high <= 0;
    always @(posedge clk)
        if(count_high == 4)
            key_out_reg <= 1;
        else if(count_low == 4)
            key_out_reg <= 0;
    assign key_out = key_out_reg;
endmodule