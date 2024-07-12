module sky130_fd_sc_hd__nand4_1 (
    Y,
    A,
    B,
    C,
    D
);
    output Y;
    input  A;
    input  B;
    input  C;
    input  D;
    wire nand0_out_Y;
    nand nand0 (nand0_out_Y, D, C, B, A     );
    buf  buf0  (Y          , nand0_out_Y    );
endmodule