module sha512_h_constants(
                          input wire  [1 : 0]  mode,
                          output wire [63 : 0] H0,
                          output wire [63 : 0] H1,
                          output wire [63 : 0] H2,
                          output wire [63 : 0] H3,
                          output wire [63 : 0] H4,
                          output wire [63 : 0] H5,
                          output wire [63 : 0] H6,
                          output wire [63 : 0] H7
                         );
  reg [63 : 0] tmp_H0;
  reg [63 : 0] tmp_H1;
  reg [63 : 0] tmp_H2;
  reg [63 : 0] tmp_H3;
  reg [63 : 0] tmp_H4;
  reg [63 : 0] tmp_H5;
  reg [63 : 0] tmp_H6;
  reg [63 : 0] tmp_H7;
  assign H0 = tmp_H0;
  assign H1 = tmp_H1;
  assign H2 = tmp_H2;
  assign H3 = tmp_H3;
  assign H4 = tmp_H4;
  assign H5 = tmp_H5;
  assign H6 = tmp_H6;
  assign H7 = tmp_H7;
  always @*
    begin : mode_mux
      case(mode)
        0:
          begin
            tmp_H0 = 64'h8c3d37c819544da2;
            tmp_H1 = 64'h73e1996689dcd4d6;
            tmp_H2 = 64'h1dfab7ae32ff9c82;
            tmp_H3 = 64'h679dd514582f9fcf;
            tmp_H4 = 64'h0f6d2b697bd44da8;
            tmp_H5 = 64'h77e36f7304c48942;
            tmp_H6 = 64'h3f9d85a86a1d36c8;
            tmp_H7 = 64'h1112e6ad91d692a1;
          end
        1:
          begin
            tmp_H0 = 64'h22312194fc2bf72c;
            tmp_H1 = 64'h9f555fa3c84c64c2;
            tmp_H2 = 64'h2393b86b6f53b151;
            tmp_H3 = 64'h963877195940eabd;
            tmp_H4 = 64'h96283ee2a88effe3;
            tmp_H5 = 64'hbe5e1e2553863992;
            tmp_H6 = 64'h2b0199fc2c85b8aa;
            tmp_H7 = 64'h0eb72ddc81c52ca2;
          end
        2:
          begin
            tmp_H0 = 64'hcbbb9d5dc1059ed8;
            tmp_H1 = 64'h629a292a367cd507;
            tmp_H2 = 64'h9159015a3070dd17;
            tmp_H3 = 64'h152fecd8f70e5939;
            tmp_H4 = 64'h67332667ffc00b31;
            tmp_H5 = 64'h8eb44a8768581511;
            tmp_H6 = 64'hdb0c2e0d64f98fa7;
            tmp_H7 = 64'h47b5481dbefa4fa4;
          end
        3:
          begin
            tmp_H0 = 64'h6a09e667f3bcc908;
            tmp_H1 = 64'hbb67ae8584caa73b;
            tmp_H2 = 64'h3c6ef372fe94f82b;
            tmp_H3 = 64'ha54ff53a5f1d36f1;
            tmp_H4 = 64'h510e527fade682d1;
            tmp_H5 = 64'h9b05688c2b3e6c1f;
            tmp_H6 = 64'h1f83d9abfb41bd6b;
            tmp_H7 = 64'h5be0cd19137e2179;
          end
      endcase 
    end 
endmodule