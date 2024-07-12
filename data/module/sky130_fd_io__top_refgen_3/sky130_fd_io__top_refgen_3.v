module sky130_fd_io__top_refgen_3 (
           input  HLD_H_N     ,
           input  IBUF_SEL    ,
           input  OD_H        ,
           input  VREF_SEL    ,
           input  VREG_EN     ,
           input  VTRIP_SEL   ,
           inout  REFLEAK_BIAS,
           output VINREF      ,
           input  VOHREF      ,
           output VOUTREF
       );
wire VCCD   ;
wire VCCHIB ;
wire VDDA   ;
wire VDDIO  ;
wire VDDIO_Q;
wire VSSD   ;
wire VSSIO  ;
wire VSSIO_Q;
endmodule