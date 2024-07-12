module sky130_fd_io__top_power_hvc_wpad_5 ( P_PAD, AMUXBUS_A, AMUXBUS_B
        , P_CORE, DRN_HVC, OGC_HVC, SRC_BDY_HVC,VSSA, VDDA, VSWITCH, VDDIO_Q, VCCHIB, VDDIO, VCCD, VSSIO, VSSD, VSSIO_Q
                                        );
inout P_PAD;
inout AMUXBUS_A;
inout AMUXBUS_B;
inout OGC_HVC;
inout DRN_HVC;
inout SRC_BDY_HVC;
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