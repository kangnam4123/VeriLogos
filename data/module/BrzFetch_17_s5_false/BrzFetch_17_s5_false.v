module BrzFetch_17_s5_false (
  activate_0r, activate_0a,
  inp_0r, inp_0a, inp_0d,
  out_0r, out_0a, out_0d
);
  input activate_0r;
  output activate_0a;
  output inp_0r;
  input inp_0a;
  input [16:0] inp_0d;
  output out_0r;
  input out_0a;
  output [16:0] out_0d;
  assign activate_0a = out_0a;
  assign out_0r = inp_0a;
  assign inp_0r = activate_0r;
  assign out_0d[0] = inp_0d[0];
  assign out_0d[1] = inp_0d[1];
  assign out_0d[2] = inp_0d[2];
  assign out_0d[3] = inp_0d[3];
  assign out_0d[4] = inp_0d[4];
  assign out_0d[5] = inp_0d[5];
  assign out_0d[6] = inp_0d[6];
  assign out_0d[7] = inp_0d[7];
  assign out_0d[8] = inp_0d[8];
  assign out_0d[9] = inp_0d[9];
  assign out_0d[10] = inp_0d[10];
  assign out_0d[11] = inp_0d[11];
  assign out_0d[12] = inp_0d[12];
  assign out_0d[13] = inp_0d[13];
  assign out_0d[14] = inp_0d[14];
  assign out_0d[15] = inp_0d[15];
  assign out_0d[16] = inp_0d[16];
endmodule