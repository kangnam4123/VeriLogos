module sky130_fd_sc_ls__xor2_6 (
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