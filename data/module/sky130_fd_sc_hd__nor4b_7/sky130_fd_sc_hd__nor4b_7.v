module sky130_fd_sc_hd__nor4b_7 (
    Y  ,
    A  ,
    B  ,
    C  ,
    D_N
);
    output Y  ;
    input  A  ;
    input  B  ;
    input  C  ;
    input  D_N;
    wire not0_out  ;
    wire nor0_out_Y;
    not not0 (not0_out  , D_N              );
    nor nor0 (nor0_out_Y, A, B, C, not0_out);
    buf buf0 (Y         , nor0_out_Y       );
endmodule