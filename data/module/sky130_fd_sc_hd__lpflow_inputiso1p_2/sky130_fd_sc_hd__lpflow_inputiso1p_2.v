module sky130_fd_sc_hd__lpflow_inputiso1p_2 (
    X    ,
    A    ,
    SLEEP
);
    output X    ;
    input  A    ;
    input  SLEEP;
    or  or0  (X     , A, SLEEP       );
endmodule