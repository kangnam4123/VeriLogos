module RRArbiter(input clk, input reset,
    output io_in_0_ready,
    input  io_in_0_valid,
    input [31:0] io_in_0_bits,
    output io_in_1_ready,
    input  io_in_1_valid,
    input [31:0] io_in_1_bits,
    input  io_out_ready,
    output io_out_valid,
    output[31:0] io_out_bits,
    output io_chosen);
  wire T0;
  wire T1;
  wire T2;
  wire T3;
  wire T4;
  wire T5;
  wire T6;
  wire T7;
  wire T8;
  wire T9;
  reg[0:0] last_grant;
  wire T10;
  wire T11;
  wire T12;
  wire choose;
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
  wire[31:0] T23;
  wire[31:0] T24;
  wire[31:0] T25;
  wire T26;
  wire[1:0] T27;
  wire[2:0] T28;
  wire[31:0] dvec_1;
  wire[31:0] T29;
  wire[31:0] T30;
  wire T31;
  wire[31:0] dvec_0;
  assign io_in_1_ready = T0;
  assign T0 = T1 && io_out_ready;
  assign T1 = T20 || T2;
  assign T2 = ! T3;
  assign T3 = T19 || io_in_0_valid;
  assign io_in_0_ready = T4;
  assign T4 = T5 && io_out_ready;
  assign T5 = T18 || T6;
  assign T6 = ! T7;
  assign T7 = T16 || T8;
  assign T8 = io_in_1_valid && T9;
  assign T9 = 1'h1 > last_grant;
  assign T10 = io_out_valid && io_out_ready;
  assign io_out_valid = T11;
  assign T11 = io_in_0_valid || io_in_1_valid;
  assign T12 = T10 ? choose : last_grant;
  assign choose = T14 ? 1'h1 : T13;
  assign T13 = io_in_0_valid ? 1'h0 : 1'h1;
  assign T14 = io_in_1_valid && T15;
  assign T15 = 1'h1 > last_grant;
  assign T16 = io_in_0_valid && T17;
  assign T17 = 1'h0 > last_grant;
  assign T18 = 1'h0 > last_grant;
  assign T19 = T16 || T8;
  assign T20 = T22 && T21;
  assign T21 = 1'h1 > last_grant;
  assign T22 = ! T16;
  assign io_out_bits = T23;
  assign T23 = T29 | T24;
  assign T24 = dvec_1 & T25;
  assign T25 = {6'h20{T26}};
  assign T26 = T27[1'h1];
  assign T27 = T28[1'h1:1'h0];
  assign T28 = 2'h1 << choose;
  assign dvec_1 = io_in_1_bits;
  assign T29 = dvec_0 & T30;
  assign T30 = {6'h20{T31}};
  assign T31 = T27[1'h0];
  assign dvec_0 = io_in_0_bits;
  always @(posedge clk) begin
    if(reset) begin
      last_grant <= 1'h0;
    end else if(T10) begin
      last_grant <= T12;
    end
  end
endmodule