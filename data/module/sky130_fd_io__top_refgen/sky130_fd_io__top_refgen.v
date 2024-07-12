module sky130_fd_io__top_refgen (
           VINREF      ,
           VOUTREF     ,
           REFLEAK_BIAS,
           HLD_H_N     ,
           IBUF_SEL    ,
           OD_H        ,
           VOHREF      ,
           VREF_SEL    ,
           VREG_EN     ,
           VTRIP_SEL
       );
output VINREF      ;
output VOUTREF     ;
inout  REFLEAK_BIAS;
input  HLD_H_N     ;
input  IBUF_SEL    ;
input  OD_H        ;
input  VOHREF      ;
input  VREF_SEL    ;
input  VREG_EN     ;
input  VTRIP_SEL   ;
wire VCCD   ;
wire VCCHIB ;
wire VDDA   ;
wire VDDIO  ;
wire VDDIO_Q;
wire VSSD   ;
wire VSSIO  ;
wire VSSIO_Q;
endmodule