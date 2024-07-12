module sky130_fd_sc_ls__nor3_5 (
    Y,
    A,
    B,
    C
);
    output Y;
    input  A;
    input  B;
    input  C;
    wire nor0_out_Y;
    nor nor0 (nor0_out_Y, C, A, B        );
    buf buf0 (Y         , nor0_out_Y     );
endmodule