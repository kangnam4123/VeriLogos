module RoundAnyRawFNToRecFN_5(
  input         io_invalidExc,
  input         io_in_isNaN,
  input         io_in_isInf,
  input         io_in_isZero,
  input         io_in_sign,
  input  [9:0]  io_in_sExp,
  input  [24:0] io_in_sig,
  output [64:0] io_out
);
  wire [11:0] _GEN_0 = {{2{io_in_sExp[9]}},io_in_sExp}; 
  wire [12:0] _sAdjustedExp_T = $signed(_GEN_0) + 12'sh700; 
  wire [12:0] sAdjustedExp = {1'b0,$signed(_sAdjustedExp_T[11:0])}; 
  wire [55:0] adjustedSig = {io_in_sig, 31'h0}; 
  wire [12:0] _common_expOut_T_1 = {{1'd0}, sAdjustedExp[11:0]}; 
  wire [11:0] common_expOut = _common_expOut_T_1[11:0]; 
  wire [51:0] common_fractOut = adjustedSig[53:2]; 
  wire  isNaNOut = io_invalidExc | io_in_isNaN; 
  wire  signOut = isNaNOut ? 1'h0 : io_in_sign; 
  wire [11:0] _expOut_T_1 = io_in_isZero ? 12'he00 : 12'h0; 
  wire [11:0] _expOut_T_2 = ~_expOut_T_1; 
  wire [11:0] _expOut_T_3 = common_expOut & _expOut_T_2; 
  wire [11:0] _expOut_T_11 = io_in_isInf ? 12'h200 : 12'h0; 
  wire [11:0] _expOut_T_12 = ~_expOut_T_11; 
  wire [11:0] _expOut_T_13 = _expOut_T_3 & _expOut_T_12; 
  wire [11:0] _expOut_T_18 = io_in_isInf ? 12'hc00 : 12'h0; 
  wire [11:0] _expOut_T_19 = _expOut_T_13 | _expOut_T_18; 
  wire [11:0] _expOut_T_20 = isNaNOut ? 12'he00 : 12'h0; 
  wire [11:0] expOut = _expOut_T_19 | _expOut_T_20; 
  wire [51:0] _fractOut_T_2 = isNaNOut ? 52'h8000000000000 : 52'h0; 
  wire [51:0] fractOut = isNaNOut | io_in_isZero ? _fractOut_T_2 : common_fractOut; 
  wire [12:0] io_out_hi = {signOut,expOut}; 
  assign io_out = {io_out_hi,fractOut}; 
endmodule