module gRRArbiter(input clk, input reset,
    input  io_out_ready,
    output io_out_valid,
    output[31:0] io_out_bits,
    output[4:0] io_out_tag,
    output io_in_0_ready,
    input  io_in_0_valid,
    input [31:0] io_in_0_bits,
    input [4:0] io_in_0_tag,
    output io_in_1_ready,
    input  io_in_1_valid,
    input [31:0] io_in_1_bits,
    input [4:0] io_in_1_tag,
    output io_chosen);
  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  reg[0:0] last_grant;
  wire T6;
  wire T7;
  wire T8;
  wire choose;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire[4:0] T23;
  wire[6:0] T24;
  wire[6:0] T25;
  wire[6:0] T26;
  wire T27;
  wire[1:0] T28;
  wire[2:0] T29;
  wire[6:0] tvec_1;
  wire[6:0] T30;
  wire[6:0] T31;
  wire[6:0] T32;
  wire T33;
  wire[6:0] tvec_0;
  wire[6:0] T34;
  wire[31:0] T35;
  wire[31:0] T36;
  wire[31:0] T37;
  wire T38;
  wire[1:0] T39;
  wire[2:0] T40;
  wire[31:0] dvec_1;
  wire[31:0] T41;
  wire[31:0] T42;
  wire T43;
  wire[31:0] dvec_0;
  assign io_in_0_ready = T0;
  assign T0 = T1 && io_out_ready;
  assign T1 = T14 || T2;
  assign T2 = ! T3;
  assign T3 = T12 || T4;
  assign T4 = io_in_1_valid && T5;
  assign T5 = 1'h1 > last_grant;
  assign T6 = io_out_valid && io_out_ready;
  assign io_out_valid = T7;
  assign T7 = io_in_0_valid || io_in_1_valid;
  assign T8 = T6 ? choose : last_grant;
  assign choose = T10 ? 1'h1 : T9;
  assign T9 = io_in_0_valid ? 1'h0 : 1'h1;
  assign T10 = io_in_1_valid && T11;
  assign T11 = 1'h1 > last_grant;
  assign T12 = io_in_0_valid && T13;
  assign T13 = 1'h0 > last_grant;
  assign T14 = 1'h0 > last_grant;
  assign io_in_1_ready = T15;
  assign T15 = T16 && io_out_ready;
  assign T16 = T20 || T17;
  assign T17 = ! T18;
  assign T18 = T19 || io_in_0_valid;
  assign T19 = T12 || T4;
  assign T20 = T22 && T21;
  assign T21 = 1'h1 > last_grant;
  assign T22 = ! T12;
  assign io_out_tag = T23;
  assign T23 = T24[3'h4:1'h0];
  assign T24 = T31 | T25;
  assign T25 = tvec_1 & T26;
  assign T26 = {3'h7{T27}};
  assign T27 = T28[1'h1];
  assign T28 = T29[1'h1:1'h0];
  assign T29 = 2'h1 << choose;
  assign tvec_1 = T30;
  assign T30 = {2'h0, io_in_1_tag};
  assign T31 = tvec_0 & T32;
  assign T32 = {3'h7{T33}};
  assign T33 = T28[1'h0];
  assign tvec_0 = T34;
  assign T34 = {2'h0, io_in_0_tag};
  assign io_out_bits = T35;
  assign T35 = T41 | T36;
  assign T36 = dvec_1 & T37;
  assign T37 = {6'h20{T38}};
  assign T38 = T39[1'h1];
  assign T39 = T40[1'h1:1'h0];
  assign T40 = 2'h1 << choose;
  assign dvec_1 = io_in_1_bits;
  assign T41 = dvec_0 & T42;
  assign T42 = {6'h20{T43}};
  assign T43 = T39[1'h0];
  assign dvec_0 = io_in_0_bits;
  always @(posedge clk) begin
    if(reset) begin
      last_grant <= 1'h0;
    end else if(T6) begin
      last_grant <= T8;
    end
  end
endmodule