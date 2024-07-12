module spi_1
(
	input        clk_sys,
	input        tx,        
	input        rx,        
	input  [7:0] din,
	output [7:0] dout,
	output       spi_clk,
	input        spi_di,
	output       spi_do
);
assign    spi_clk = counter[0];
assign    spi_do  = io_byte[7]; 
assign    dout    = data;
reg [4:0] counter = 5'b10000;  
reg [7:0] io_byte, data;
always @(negedge clk_sys) begin
    if(counter[4]) begin
        if(rx | tx) begin
            counter <= 0;
            data <= io_byte;
            io_byte <= tx ? din : 8'hff;
        end
    end else begin
        if(spi_clk) io_byte <= { io_byte[6:0], spi_di };
        counter <= counter + 2'd1;
    end
end
endmodule