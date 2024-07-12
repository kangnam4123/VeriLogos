module sky130_fd_sc_lp__busdrivernovlpsleep_1 (
    Z    ,
    A    ,
    TE_B ,
    SLEEP,
    VPWR ,
    VGND ,
    KAPWR,
    VPB  ,
    VNB
);
    output Z    ;
    input  A    ;
    input  TE_B ;
    input  SLEEP;
    input  VPWR ;
    input  VGND ;
    input  KAPWR;
    input  VPB  ;
    input  VNB  ;
    wire nor_teb_SLEEP;
    wire zgnd         ;
    wire zpwr         ;
    nor    nor0    (nor_teb_SLEEP, TE_B, SLEEP        );
    bufif1 bufif10 (zgnd         , A, VPWR            );
    bufif0 bufif00 (zpwr         , zgnd, VGND         );
    bufif1 bufif11 (Z            , zpwr, nor_teb_SLEEP);
endmodule