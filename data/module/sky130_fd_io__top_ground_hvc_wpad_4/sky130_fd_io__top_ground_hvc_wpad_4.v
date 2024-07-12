module sky130_fd_io__top_ground_hvc_wpad_4 ( G_PAD, AMUXBUS_A, AMUXBUS_B
        , G_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                         );
inout G_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
inout G_CORE;
inout VDDIO;
inout VDDIO_Q;
inout VDDA;
inout VCCD;
inout VSWITCH;
inout VCCHIB;
inout VSSA;
inout VSSD;
inout VSSIO_Q;
inout VSSIO;
assign G_CORE = G_PAD;
endmodule