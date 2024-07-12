module delayLine #(
        parameter   DELAY = 0,
        parameter   WIDTH = 8
    )(
        input                   ce,
        input                   rst,
        input                   clk,
        input  [WIDTH - 1:0]    in,
        output [WIDTH - 1:0]    out
    );
    wire [WIDTH - 1:0]  chain [DELAY:0];
    assign chain[0] = in;
    assign out      = chain[DELAY];
    genvar i;
    generate
        for(i = 0; i < DELAY; i = i + 1)
        begin : chain_connector
            wlatch #(
                .WIDTH(WIDTH)
            )
            lat (
                .ce(ce),
                .rst(rst),
                .clk(clk),
                .in(chain[i]),
                .out(chain[i + 1])
            );
        end
    endgenerate
endmodule