module bw_clk_gclk_inv_r90_192x (
    clkout,
    clkin );
    output clkout;
    input  clkin;
    assign clkout = ~( clkin );
endmodule