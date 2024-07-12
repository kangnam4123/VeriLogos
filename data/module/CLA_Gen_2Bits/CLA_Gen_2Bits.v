module CLA_Gen_2Bits(PPP,GPP,C4,PP,GP,CI);
  output          PPP, GPP, C4;
  input  [1:0]    PP, GP;
  input           CI;
  assign C4=GP[0] | PP[0]&CI,
         GPP=GP[1] | PP[1]&GP[0],
         PPP=PP[1]&PP[0];
endmodule