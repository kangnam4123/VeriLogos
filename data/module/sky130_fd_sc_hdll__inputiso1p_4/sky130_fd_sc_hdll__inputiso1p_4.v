module sky130_fd_sc_hdll__inputiso1p_4 (
    X    ,
    A    ,
    SLEEP
);
    output X    ;
    input  A    ;
    input  SLEEP;
    or  or0  (X     , A, SLEEP       );
endmodule