module sky130_fd_sc_ls__o32ai_5 (
    Y ,
    A1,
    A2,
    A3,
    B1,
    B2
);
    output Y ;
    input  A1;
    input  A2;
    input  A3;
    input  B1;
    input  B2;
    wire nor0_out ;
    wire nor1_out ;
    wire or0_out_Y;
    nor nor0 (nor0_out , A3, A1, A2        );
    nor nor1 (nor1_out , B1, B2            );
    or  or0  (or0_out_Y, nor1_out, nor0_out);
    buf buf0 (Y        , or0_out_Y         );
endmodule