module OBUFTDS_M_VPR (
    input  I,
    input  T,
    output O,
    output OB
);
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] LVDS_25_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] LVDS_25_OUT = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;
  parameter [0:0] TMDS_33_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] TMDS_33_OUT = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;
  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;
  parameter PULLTYPE = "";
  parameter IOSTANDARD = "";
  parameter SLEW = "";
  assign O  = (T == 1'b0) ?  I : 1'bz;
  assign OB = (T == 1'b0) ? !I : 1'bz;
endmodule