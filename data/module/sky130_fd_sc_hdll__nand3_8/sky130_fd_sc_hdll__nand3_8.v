module sky130_fd_sc_hdll__nand3_8 (
    Y,
    A,
    B,
    C
);
    output Y;
    input  A;
    input  B;
    input  C;
    wire nand0_out_Y;
    nand nand0 (nand0_out_Y, B, A, C        );
    buf  buf0  (Y          , nand0_out_Y    );
endmodule