module sky130_fd_sc_ls__xnor3_6 (
    X,
    A,
    B,
    C
);
    output X;
    input  A;
    input  B;
    input  C;
    wire xnor0_out_X;
    xnor xnor0 (xnor0_out_X, A, B, C        );
    buf  buf0  (X          , xnor0_out_X    );
endmodule