module clock_10 #(
    parameter                              SCALE            = 2    
) (
    output                              clk_o,    
    output                              rst_o,    
    input                               clk_i,    
    input                               rst_i    
);
assign clk_o = clk_i;
assign rst_o = rst_i;
endmodule