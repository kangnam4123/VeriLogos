module sky130_fd_sc_hd__xor2_4 (
    X,
    A,
    B
);
    output X;
    input  A;
    input  B;
    wire xor0_out_X;
    xor xor0 (xor0_out_X, B, A           );
    buf buf0 (X         , xor0_out_X     );
endmodule