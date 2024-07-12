module sky130_fd_sc_hd__a221o_2 (
    X ,
    A1,
    A2,
    B1,
    B2,
    C1
);
    output X ;
    input  A1;
    input  A2;
    input  B1;
    input  B2;
    input  C1;
    wire and0_out ;
    wire and1_out ;
    wire or0_out_X;
    and and0 (and0_out , B1, B2                );
    and and1 (and1_out , A1, A2                );
    or  or0  (or0_out_X, and1_out, and0_out, C1);
    buf buf0 (X        , or0_out_X             );
endmodule