module sky130_fd_sc_hd__nand2_7 (
    Y,
    A,
    B
);
    output Y;
    input  A;
    input  B;
    wire nand0_out_Y;
    nand nand0 (nand0_out_Y, B, A           );
    buf  buf0  (Y          , nand0_out_Y    );
endmodule