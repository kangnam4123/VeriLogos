module sky130_fd_sc_ls__and4b_3 (
    X  ,
    A_N,
    B  ,
    C  ,
    D
);
    output X  ;
    input  A_N;
    input  B  ;
    input  C  ;
    input  D  ;
    wire not0_out  ;
    wire and0_out_X;
    not not0 (not0_out  , A_N              );
    and and0 (and0_out_X, not0_out, B, C, D);
    buf buf0 (X         , and0_out_X       );
endmodule