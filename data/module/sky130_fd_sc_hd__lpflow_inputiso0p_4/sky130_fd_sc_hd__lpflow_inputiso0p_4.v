module sky130_fd_sc_hd__lpflow_inputiso0p_4 (
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