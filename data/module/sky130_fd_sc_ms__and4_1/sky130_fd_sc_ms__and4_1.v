module sky130_fd_sc_ms__and4_1 (
    X,
    A,
    B,
    C,
    D
);
    output X;
    input  A;
    input  B;
    input  C;
    input  D;
    wire and0_out_X;
    and and0 (and0_out_X, A, B, C, D     );
    buf buf0 (X         , and0_out_X     );
endmodule