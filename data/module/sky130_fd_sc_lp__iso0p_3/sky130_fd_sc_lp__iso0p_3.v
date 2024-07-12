module sky130_fd_sc_lp__iso0p_3 (
    X    ,
    A    ,
    SLEEP
);
    output X    ;
    input  A    ;
    input  SLEEP;
    wire sleepn;
    not not0 (sleepn, SLEEP          );
    and and0 (X     , A, sleepn      );
endmodule