module sky130_fd_sc_ls__a311oi_7 (
    Y ,
    A1,
    A2,
    A3,
    B1,
    C1
);
    output Y ;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  C1;
    wire and0_out  ;
    wire nor0_out_Y;
    and and0 (and0_out  , A3, A1, A2      );
    nor nor0 (nor0_out_Y, and0_out, B1, C1);
    buf buf0 (Y         , nor0_out_Y      );
endmodule