module sky130_fd_sc_lp__inputiso0n_5 (
    X      ,
    A      ,
    SLEEP_B
);
    output X      ;
    input  A      ;
    input  SLEEP_B;
    and and0 (X     , A, SLEEP_B     );
endmodule