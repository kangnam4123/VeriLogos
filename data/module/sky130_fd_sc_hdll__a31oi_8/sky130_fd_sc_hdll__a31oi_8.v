module sky130_fd_sc_hdll__a31oi_8 (
    Y ,
    A1,
    A2,
    A3,
    B1
);
    output Y ;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    wire and0_out  ;
    wire nor0_out_Y;
    and and0 (and0_out  , A3, A1, A2     );
    nor nor0 (nor0_out_Y, B1, and0_out   );
    buf buf0 (Y         , nor0_out_Y     );
endmodule