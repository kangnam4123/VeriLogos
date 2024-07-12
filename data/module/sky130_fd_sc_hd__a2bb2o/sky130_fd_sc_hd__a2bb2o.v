module sky130_fd_sc_hd__a2bb2o (
    X   ,
    A1_N,
    A2_N,
    B1  ,
    B2
);
    output X   ;
    input  A1_N;
    input  A2_N;
    input  B1  ;
    input  B2  ;
    wire and0_out ;
    wire nor0_out ;
    wire or0_out_X;
    and and0 (and0_out , B1, B2            );
    nor nor0 (nor0_out , A1_N, A2_N        );
    or  or0  (or0_out_X, nor0_out, and0_out);
    buf buf0 (X        , or0_out_X         );
endmodule