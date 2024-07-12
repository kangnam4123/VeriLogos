module sky130_fd_sc_lp__o211a_2 (
    X ,
    A1,
    A2,
    B1,
    C1
);
    output X ;
    input  A1;
    input  A2;
    input  B1;
    input  C1;
    wire or0_out   ;
    wire and0_out_X;
    or  or0  (or0_out   , A2, A1         );
    and and0 (and0_out_X, or0_out, B1, C1);
    buf buf0 (X         , and0_out_X     );
endmodule