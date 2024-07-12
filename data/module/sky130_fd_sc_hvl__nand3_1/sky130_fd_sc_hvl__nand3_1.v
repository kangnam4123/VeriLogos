module sky130_fd_sc_hvl__nand3_1 (
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