module sky130_fd_sc_ls__dlymetal6s6s_6 (
    X,
    A
);
    output X;
    input  A;
    wire buf0_out_X;
    buf buf0 (buf0_out_X, A              );
    buf buf1 (X         , buf0_out_X     );
endmodule