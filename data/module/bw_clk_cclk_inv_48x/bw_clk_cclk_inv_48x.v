module bw_clk_cclk_inv_48x (
    clkout,
    clkin );
    output clkout;
    input  clkin;
    assign clkout = ~( clkin );
endmodule