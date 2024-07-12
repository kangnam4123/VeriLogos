module sky130_fd_sc_hdll__dlygate4sd2_5 (
    X,
    A
);
    output X;
    input  A;
    wire buf0_out_X;
    buf buf0 (buf0_out_X, A              );
    buf buf1 (X         , buf0_out_X     );
endmodule