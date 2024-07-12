module sky130_fd_sc_lp__iso1p_6 (
    X    ,
    A    ,
    SLEEP
);
    output X    ;
    input  A    ;
    input  SLEEP;
    or  or0  (X     , A, SLEEP       );
endmodule