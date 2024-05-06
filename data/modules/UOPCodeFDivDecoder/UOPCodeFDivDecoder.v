module UOPCodeFDivDecoder(
  input  [6:0] io_uopc,
  output [1:0] io_sigs_typeTagIn,
  output       io_sigs_div,
  output       io_sigs_sqrt
);
  wire [6:0] _decoder_T_2 = io_uopc & 7'ha; 
  wire  _decoder_T_3 = _decoder_T_2 == 7'h0; 
  wire [6:0] _decoder_T_4 = io_uopc & 7'h9; 
  wire  _decoder_T_5 = _decoder_T_4 == 7'h0; 
  wire [6:0] _decoder_T_7 = io_uopc & 7'h1; 
  wire  decoder_7 = _decoder_T_7 == 7'h0; 
  wire [6:0] _decoder_T_10 = io_uopc & 7'h4; 
  wire  _decoder_T_11 = _decoder_T_10 == 7'h0; 
  wire [6:0] _decoder_T_12 = io_uopc & 7'h3; 
  wire  _decoder_T_13 = _decoder_T_12 == 7'h3; 
  assign io_sigs_typeTagIn = {{1'd0}, decoder_7}; 
  assign io_sigs_div = _decoder_T_3 | _decoder_T_5; 
  assign io_sigs_sqrt = _decoder_T_11 | _decoder_T_13; 
endmodule