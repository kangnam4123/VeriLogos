module sky130_fd_sc_ls__or4b_7 (
    X  ,
    A  ,
    B  ,
    C  ,
    D_N
);
    output X  ;
    input  A  ;
    input  B  ;
    input  C  ;
    input  D_N;
    wire not0_out ;
    wire or0_out_X;
    not not0 (not0_out , D_N              );
    or  or0  (or0_out_X, not0_out, C, B, A);
    buf buf0 (X        , or0_out_X        );
endmodule