module MuxN_4(
  input         io_ins_0_valid,
  input  [31:0] io_ins_0_bits_wdata_0,
  input  [31:0] io_ins_0_bits_wdata_1,
  input  [31:0] io_ins_0_bits_wdata_2,
  input  [31:0] io_ins_0_bits_wdata_3,
  input  [31:0] io_ins_0_bits_wdata_4,
  input  [31:0] io_ins_0_bits_wdata_5,
  input  [31:0] io_ins_0_bits_wdata_6,
  input  [31:0] io_ins_0_bits_wdata_7,
  input  [31:0] io_ins_0_bits_wdata_8,
  input  [31:0] io_ins_0_bits_wdata_9,
  input  [31:0] io_ins_0_bits_wdata_10,
  input  [31:0] io_ins_0_bits_wdata_11,
  input  [31:0] io_ins_0_bits_wdata_12,
  input  [31:0] io_ins_0_bits_wdata_13,
  input  [31:0] io_ins_0_bits_wdata_14,
  input  [31:0] io_ins_0_bits_wdata_15,
  input         io_ins_0_bits_wlast,
  output        io_out_valid,
  output [31:0] io_out_bits_wdata_0,
  output [31:0] io_out_bits_wdata_1,
  output [31:0] io_out_bits_wdata_2,
  output [31:0] io_out_bits_wdata_3,
  output [31:0] io_out_bits_wdata_4,
  output [31:0] io_out_bits_wdata_5,
  output [31:0] io_out_bits_wdata_6,
  output [31:0] io_out_bits_wdata_7,
  output [31:0] io_out_bits_wdata_8,
  output [31:0] io_out_bits_wdata_9,
  output [31:0] io_out_bits_wdata_10,
  output [31:0] io_out_bits_wdata_11,
  output [31:0] io_out_bits_wdata_12,
  output [31:0] io_out_bits_wdata_13,
  output [31:0] io_out_bits_wdata_14,
  output [31:0] io_out_bits_wdata_15,
  output        io_out_bits_wlast
);
  assign io_out_valid = io_ins_0_valid;
  assign io_out_bits_wdata_0 = io_ins_0_bits_wdata_0;
  assign io_out_bits_wdata_1 = io_ins_0_bits_wdata_1;
  assign io_out_bits_wdata_2 = io_ins_0_bits_wdata_2;
  assign io_out_bits_wdata_3 = io_ins_0_bits_wdata_3;
  assign io_out_bits_wdata_4 = io_ins_0_bits_wdata_4;
  assign io_out_bits_wdata_5 = io_ins_0_bits_wdata_5;
  assign io_out_bits_wdata_6 = io_ins_0_bits_wdata_6;
  assign io_out_bits_wdata_7 = io_ins_0_bits_wdata_7;
  assign io_out_bits_wdata_8 = io_ins_0_bits_wdata_8;
  assign io_out_bits_wdata_9 = io_ins_0_bits_wdata_9;
  assign io_out_bits_wdata_10 = io_ins_0_bits_wdata_10;
  assign io_out_bits_wdata_11 = io_ins_0_bits_wdata_11;
  assign io_out_bits_wdata_12 = io_ins_0_bits_wdata_12;
  assign io_out_bits_wdata_13 = io_ins_0_bits_wdata_13;
  assign io_out_bits_wdata_14 = io_ins_0_bits_wdata_14;
  assign io_out_bits_wdata_15 = io_ins_0_bits_wdata_15;
  assign io_out_bits_wlast = io_ins_0_bits_wlast;
endmodule