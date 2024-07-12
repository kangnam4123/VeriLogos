module sky130_fd_sc_ms__a222o_5 (
    X ,
    A1,
    A2,
    B1,
    B2,
    C1,
    C2
);
    output X ;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  C1;
    input  C2;
    wire and0_out ;
    wire and1_out ;
    wire and2_out ;
    wire or0_out_X;
    and and0 (and0_out , B1, B2                      );
    and and1 (and1_out , A1, A2                      );
    and and2 (and2_out , C1, C2                      );
    or  or0  (or0_out_X, and1_out, and0_out, and2_out);
    buf buf0 (X        , or0_out_X                   );
endmodule