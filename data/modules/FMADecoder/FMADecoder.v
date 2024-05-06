module FMADecoder(
  input  [6:0] io_uopc,
  output [1:0] io_cmd
);
  wire [6:0] _decoder_T = io_uopc & 7'h27; 
  wire  _decoder_T_1 = _decoder_T == 7'h0; 
  wire [6:0] _decoder_T_2 = io_uopc & 7'h12; 
  wire  _decoder_T_3 = _decoder_T_2 == 7'h2; 
  wire [6:0] _decoder_T_4 = io_uopc & 7'hb; 
  wire  _decoder_T_5 = _decoder_T_4 == 7'hb; 
  wire [6:0] _decoder_T_6 = io_uopc & 7'he; 
  wire  _decoder_T_7 = _decoder_T_6 == 7'he; 
  wire  _decoder_T_11 = _decoder_T_1 | _decoder_T_3 | _decoder_T_5 | _decoder_T_7; 
  wire [6:0] _decoder_T_12 = io_uopc & 7'h13; 
  wire  _decoder_T_13 = _decoder_T_12 == 7'h0; 
  wire  _decoder_T_15 = _decoder_T_12 == 7'h3; 
  wire [6:0] _decoder_T_16 = io_uopc & 7'hf; 
  wire  _decoder_T_17 = _decoder_T_16 == 7'hf; 
  wire  _decoder_T_20 = _decoder_T_13 | _decoder_T_15 | _decoder_T_17; 
  assign io_cmd = {_decoder_T_20,_decoder_T_11}; 
endmodule