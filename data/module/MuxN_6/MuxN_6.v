module MuxN_6(
  input         io_ins_0_valid,
  input  [63:0] io_ins_0_bits_addr,
  input  [31:0] io_ins_0_bits_size,
  input         io_ins_0_bits_isWr,
  input  [31:0] io_ins_0_bits_tag,
  input  [31:0] io_ins_0_bits_streamId,
  input         io_ins_1_valid,
  input  [63:0] io_ins_1_bits_addr,
  input  [31:0] io_ins_1_bits_size,
  input         io_ins_1_bits_isWr,
  input  [31:0] io_ins_1_bits_tag,
  input  [31:0] io_ins_1_bits_streamId,
  input         io_sel,
  output        io_out_valid,
  output [63:0] io_out_bits_addr,
  output [31:0] io_out_bits_size,
  output        io_out_bits_isWr,
  output [31:0] io_out_bits_tag,
  output [31:0] io_out_bits_streamId
);
  wire  _GEN_9;
  wire [63:0] _GEN_10;
  wire [31:0] _GEN_11;
  wire  _GEN_13;
  wire [31:0] _GEN_15;
  wire [31:0] _GEN_16;
  wire [31:0] _GEN_1_bits_streamId;
  wire [31:0] _GEN_2_bits_tag;
  wire  _GEN_4_bits_isWr;
  wire [31:0] _GEN_6_bits_size;
  wire [63:0] _GEN_7_bits_addr;
  wire  _GEN_8_valid;
  assign _GEN_9 = io_sel ? io_ins_1_valid : io_ins_0_valid;
  assign _GEN_10 = io_sel ? io_ins_1_bits_addr : io_ins_0_bits_addr;
  assign _GEN_11 = io_sel ? io_ins_1_bits_size : io_ins_0_bits_size;
  assign _GEN_13 = io_sel ? io_ins_1_bits_isWr : io_ins_0_bits_isWr;
  assign _GEN_15 = io_sel ? io_ins_1_bits_tag : io_ins_0_bits_tag;
  assign _GEN_16 = io_sel ? io_ins_1_bits_streamId : io_ins_0_bits_streamId;
  assign io_out_valid = _GEN_8_valid;
  assign io_out_bits_addr = _GEN_7_bits_addr;
  assign io_out_bits_size = _GEN_6_bits_size;
  assign io_out_bits_isWr = _GEN_4_bits_isWr;
  assign io_out_bits_tag = _GEN_2_bits_tag;
  assign io_out_bits_streamId = _GEN_1_bits_streamId;
  assign _GEN_1_bits_streamId = _GEN_16;
  assign _GEN_2_bits_tag = _GEN_15;
  assign _GEN_4_bits_isWr = _GEN_13;
  assign _GEN_6_bits_size = _GEN_11;
  assign _GEN_7_bits_addr = _GEN_10;
  assign _GEN_8_valid = _GEN_9;
endmodule