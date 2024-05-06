module DCacheModuleImpl_Anon_2(
  input         io_in_0_valid,
  input  [11:0] io_in_0_bits_addr,
  input         io_in_0_bits_write,
  input  [63:0] io_in_0_bits_wdata,
  input  [7:0]  io_in_0_bits_eccMask,
  input  [3:0]  io_in_0_bits_way_en,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [11:0] io_in_1_bits_addr,
  input         io_in_1_bits_write,
  input  [63:0] io_in_1_bits_wdata,
  input  [3:0]  io_in_1_bits_way_en,
  output        io_in_2_ready,
  input         io_in_2_valid,
  input  [11:0] io_in_2_bits_addr,
  input  [63:0] io_in_2_bits_wdata,
  output        io_in_3_ready,
  input         io_in_3_valid,
  input  [11:0] io_in_3_bits_addr,
  input  [63:0] io_in_3_bits_wdata,
  input         io_in_3_bits_wordMask,
  output        io_out_valid,
  output [11:0] io_out_bits_addr,
  output        io_out_bits_write,
  output [63:0] io_out_bits_wdata,
  output [7:0]  io_out_bits_eccMask,
  output [3:0]  io_out_bits_way_en
);
  wire [63:0] _GEN_4 = io_in_2_valid ? io_in_2_bits_wdata : io_in_3_bits_wdata; 
  wire [11:0] _GEN_6 = io_in_2_valid ? io_in_2_bits_addr : io_in_3_bits_addr; 
  wire [3:0] _GEN_8 = io_in_1_valid ? io_in_1_bits_way_en : 4'hf; 
  wire [63:0] _GEN_11 = io_in_1_valid ? io_in_1_bits_wdata : _GEN_4; 
  wire [11:0] _GEN_13 = io_in_1_valid ? io_in_1_bits_addr : _GEN_6; 
  wire  grant_3 = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); 
  assign io_in_1_ready = ~io_in_0_valid; 
  assign io_in_2_ready = ~(io_in_0_valid | io_in_1_valid); 
  assign io_in_3_ready = ~(io_in_0_valid | io_in_1_valid | io_in_2_valid); 
  assign io_out_valid = ~grant_3 | io_in_3_valid; 
  assign io_out_bits_addr = io_in_0_valid ? io_in_0_bits_addr : _GEN_13; 
  assign io_out_bits_write = io_in_0_valid ? io_in_0_bits_write : io_in_1_valid & io_in_1_bits_write; 
  assign io_out_bits_wdata = io_in_0_valid ? io_in_0_bits_wdata : _GEN_11; 
  assign io_out_bits_eccMask = io_in_0_valid ? io_in_0_bits_eccMask : 8'hff; 
  assign io_out_bits_way_en = io_in_0_valid ? io_in_0_bits_way_en : _GEN_8; 
endmodule