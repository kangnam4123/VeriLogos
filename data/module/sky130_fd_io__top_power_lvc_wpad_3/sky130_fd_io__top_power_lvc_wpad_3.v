module sky130_fd_io__top_power_lvc_wpad_3 ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, BDY2_B2B, DRN_LVC1, DRN_LVC2, OGC_LVC, SRC_BDY_LVC1, SRC_BDY_LVC2, VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout SRC_BDY_LVC1;
inout SRC_BDY_LVC2;
inout OGC_LVC;
inout DRN_LVC1;
inout BDY2_B2B;
inout DRN_LVC2;
inout P_CORE;
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
assign P_CORE = P_PAD;
endmodule