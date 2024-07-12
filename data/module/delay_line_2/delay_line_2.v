module delay_line_2 #(
        parameter   DELAY = 0,
        parameter   WIDTH = 1
    )(
        input                   ce,
        input                   rst,
        input                   clk,
        input  [WIDTH - 1:0]    in,
        output [WIDTH - 1:0]    out
    );
    wire [WIDTH - 1:0]  chain [DELAY:0];
    assign chain[0] = in;
    assign out  = chain[DELAY];
    generate
        genvar i;
        for(i = 0; i < DELAY; i = i + 1)
            latch #(
                .WIDTH(WIDTH)
            )
            lat (
                .ce(ce),
                .rst(rst),
                .clk(clk),
                .in(chain[i]),
                .out(chain[i + 1])
            );
    endgenerate
endmodule