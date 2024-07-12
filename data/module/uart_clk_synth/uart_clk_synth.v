module uart_clk_synth(
    input clk,
    output reg uart_8x_tick = 0
    );
    reg [2:0] clk_div = 0;
    always @ (posedge clk) begin
        clk_div <= clk_div + 1;
        uart_8x_tick <= 0;
        if (clk_div == 6) begin
            clk_div <= 0;
            uart_8x_tick <= 1;
        end
    end
endmodule