module ad_sysref_gen (
    input       core_clk,
    input       sysref_en,
    output reg  sysref_out
);
  parameter    SYSREF_PERIOD = 128;
  localparam   SYSREF_HALFPERIOD = SYSREF_PERIOD/2 - 1;
  reg  [ 7:0]   counter;
  reg           sysref_en_m1;
  reg           sysref_en_m2;
  reg           sysref_en_int;
  always @(posedge core_clk) begin
    sysref_en_m1 <= sysref_en;
    sysref_en_m2 <= sysref_en_m1;
    sysref_en_int <= sysref_en_m2;
  end
  always @(posedge core_clk) begin
    if (sysref_en_int) begin
      counter <= (counter < SYSREF_HALFPERIOD) ? counter + 1'b1 : 8'h0;
    end else begin
      counter <= 8'h0;
    end
  end
  always @(posedge core_clk) begin
    if (sysref_en_int) begin
      if (counter == SYSREF_HALFPERIOD) begin
        sysref_out <= ~sysref_out;
      end
    end else begin
      sysref_out <= 1'b0;
    end
  end
endmodule