module Counter_RV1_Timer (
  input Reset_n_i,
  input Clk_i,
  input Preset_i,
  input Enable_i,
  input[15:0] PresetVal_i,
  output Zero_o
);
  localparam Width = 16;
  reg [Width-1:0] Value;
  always @(negedge Reset_n_i or posedge Clk_i)
  begin
    if (!Reset_n_i)
    begin
      Value <= 'd0;
    end
    else
    begin
      if (Preset_i) begin
        Value <= PresetVal_i;
      end else if (Enable_i)
      begin
        Value <= Value - 1'b1;
      end
    end
  end
  assign Zero_o = (Value == 0 ? 1'b1 : 1'b0);
endmodule