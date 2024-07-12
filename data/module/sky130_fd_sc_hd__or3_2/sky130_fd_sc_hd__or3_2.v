module sky130_fd_sc_hd__or3_2 (
    X,
    A,
    B,
    C
);
    output X;
    input  A;
    input  B;
    input  C;
    wire or0_out_X;
    or  or0  (or0_out_X, B, A, C        );
    buf buf0 (X        , or0_out_X      );
endmodule