module IOBUF_VPR (
    input  I,
    input  T,
    output O,
    input  IOPAD_$inp,
    output IOPAD_$out
);
  parameter [0:0] LVCMOS12_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS12_DRIVE_I4 = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_IN = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SLEW_FAST = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS25_DRIVE_I8 = 1'b0;
  parameter [0:0] LVCMOS15_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS15_DRIVE_I8 = 1'b0;
  parameter [0:0] LVCMOS15_LVCMOS18_LVCMOS25_DRIVE_I4 = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I12_I8 = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I24 = 1'b0;
  parameter [0:0] LVCMOS25_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS25_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS25_LVCMOS33_LVTTL_IN = 1'b0;
  parameter [0:0] LVCMOS33_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I12_I16 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I12_I8 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I4 = 1'b0;
  parameter [0:0] LVTTL_DRIVE_I24 = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_IN = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;
  parameter [0:0] IBUF_LOW_PWR = 1'b0;
  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;
  parameter PULLTYPE = "";
  parameter IOSTANDARD = "";
  parameter DRIVE = 0;
  parameter SLEW = "";
  assign O = IOPAD_$inp;
  assign IOPAD_$out = (T == 1'b0) ? I : 1'bz;
endmodule