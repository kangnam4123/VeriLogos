module uart_clock#(
    parameter BUS_FREQ = 100                    
    )(
    input   clk,
    output  uart_tick,
    output  uart_tick_16x
    );
    localparam integer INCREMENT    = 151;                                        
    localparam real    COUNT_RANGE  = (((BUS_FREQ*1000000)/115200)*INCREMENT)/16; 
    localparam integer RANGE        = (COUNT_RANGE <= 1 << 1)  ? 1  :
                                      (COUNT_RANGE <= 1 << 2)  ? 2  :
                                      (COUNT_RANGE <= 1 << 3)  ? 3  :
                                      (COUNT_RANGE <= 1 << 4)  ? 4  :
                                      (COUNT_RANGE <= 1 << 5)  ? 5  :
                                      (COUNT_RANGE <= 1 << 6)  ? 6  :
                                      (COUNT_RANGE <= 1 << 7)  ? 7  :
                                      (COUNT_RANGE <= 1 << 8)  ? 8  :
                                      (COUNT_RANGE <= 1 << 9)  ? 9  :
                                      (COUNT_RANGE <= 1 << 10) ? 10 :
                                      (COUNT_RANGE <= 1 << 11) ? 11 :
                                      (COUNT_RANGE <= 1 << 12) ? 12 :
                                      (COUNT_RANGE <= 1 << 13) ? 13 :
                                      (COUNT_RANGE <= 1 << 14) ? 14 :
                                      (COUNT_RANGE <= 1 << 15) ? 15 :
                                      (COUNT_RANGE <= 1 << 16) ? 16 :
                                      (COUNT_RANGE <= 1 << 17) ? 17 :
                                      (COUNT_RANGE <= 1 << 18) ? 18 :
                                      (COUNT_RANGE <= 1 << 19) ? 19 : 20;
    reg [RANGE : 0] accumulator = 0;
    always @(posedge clk) begin
        accumulator <= accumulator[RANGE - 1 : 0] + INCREMENT; 
    end
    assign uart_tick_16x = accumulator[RANGE];
    reg [3:0] uart_16x_count = 4'h0;
    always @(posedge clk) begin
        uart_16x_count <= (uart_tick_16x) ? uart_16x_count + 4'b1 : uart_16x_count;
    end
    assign uart_tick = (uart_tick_16x==1'b1 && (uart_16x_count == 4'b1111));
endmodule