module prim_clock_gating (
  input  clock,
  input  en_i,
  input  test_en_i,
  output clk_o
);
  reg en_latch;
  always @* begin
    if (!clock) begin
      en_latch = en_i | test_en_i;
    end
  end
  assign clk_o = en_latch & clock;
endmodule