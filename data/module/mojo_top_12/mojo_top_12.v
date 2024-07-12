module mojo_top_12(
    input clk,
    input rst_n,
    input cclk,
    output[7:0]led,
    output spi_miso,
    input spi_ss,
    input spi_mosi,
    input spi_sck,
    output [3:0] spi_channel,
    input avr_tx, 
    output avr_rx, 
    input avr_rx_busy 
    );
wire rst = ~rst_n; 
wire [9:0] array; 
assign spi_miso = 1'bz;   
assign avr_rx = 1'bz;
assign spi_channel = 4'bzzzz;
assign led[6:0] = 7'b0; 
assign led[7] = rst; 
endmodule