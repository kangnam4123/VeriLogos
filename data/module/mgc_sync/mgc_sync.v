module mgc_sync (ldin, vdin, ldout, vdout);
  input  ldin;
  output vdin;
  input  ldout;
  output vdout;
  wire   vdin;
  wire   vdout;
  assign vdin = ldout;
  assign vdout = ldin;
endmodule