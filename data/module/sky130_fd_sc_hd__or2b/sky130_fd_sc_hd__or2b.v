module sky130_fd_sc_hd__or2b (
    X  ,
    A  ,
    B_N
);
    output X  ;
    input  A  ;
    input  B_N;
    wire not0_out ;
    wire or0_out_X;
    not not0 (not0_out , B_N            );
    or  or0  (or0_out_X, not0_out, A    );
    buf buf0 (X        , or0_out_X      );
endmodule