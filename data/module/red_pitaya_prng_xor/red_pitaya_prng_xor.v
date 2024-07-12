module red_pitaya_prng_xor #(
    parameter     B1 = 13,
    parameter     B2 = 17,
    parameter     B3 = 5,
    parameter     SEED1 = 1,
    parameter     SEED2 = 2,
    parameter     SEED3 = 3,
    parameter     STATEBITS = 32,
    parameter     OUTBITS   = 14
)
(
    input clk_i,
    input reset_i  ,
    output signed [OUTBITS-1:0] signal_o
);
reg [STATEBITS-1:0] x1;
reg [STATEBITS-1:0] x2;
reg [STATEBITS-1:0] x3;
always @(posedge clk_i) begin
  if (reset_i == 1'b0) begin
     x1 <= SEED1;
     x2 <= SEED2;
     x3 <= SEED3;
  end
  else begin
     x1 <= x3 ^ (x3 >> B1);
     x2 <= x1 ^ (x1 << B2);
     x3 <= x2 ^ (x2 >> B3);
  end
end
assign signal_o = x3[STATEBITS-1:STATEBITS-OUTBITS];
endmodule