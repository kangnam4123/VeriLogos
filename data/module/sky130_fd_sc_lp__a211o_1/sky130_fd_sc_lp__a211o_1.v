module sky130_fd_sc_lp__a211o_1 (
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
    wire and0_out ;
    wire or0_out_X;
    and and0 (and0_out , A1, A2          );
    or  or0  (or0_out_X, and0_out, C1, B1);
    buf buf0 (X        , or0_out_X       );
endmodule