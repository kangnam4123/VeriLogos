module sky130_fd_sc_ms__or3b_2 (
    X  ,
    A  ,
    B  ,
    C_N
);
    output X  ;
    input  A  ;
    input  B  ;
    input  C_N;
    wire not0_out ;
    wire or0_out_X;
    not not0 (not0_out , C_N            );
    or  or0  (or0_out_X, B, A, not0_out );
    buf buf0 (X        , or0_out_X      );
endmodule