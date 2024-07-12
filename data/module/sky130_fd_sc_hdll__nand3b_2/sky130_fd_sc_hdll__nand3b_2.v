module sky130_fd_sc_hdll__nand3b_2 (
    Y  ,
    A_N,
    B  ,
    C
);
    output Y  ;
    input  A_N;
    input  B  ;
    input  C  ;
    wire not0_out   ;
    wire nand0_out_Y;
    not  not0  (not0_out   , A_N            );
    nand nand0 (nand0_out_Y, B, not0_out, C );
    buf  buf0  (Y          , nand0_out_Y    );
endmodule