module ad_rst (
  preset,
  clk,
  rst);
  input           preset;
  input           clk;
  output          rst;
  reg             rst_p = 'd0;
  reg             rst = 'd0;
  always @(posedge clk or posedge preset) begin
    if (preset == 1'b1) begin
      rst_p <= 1'd1;
      rst <= 1'd1;
    end else begin
      rst_p <= 1'b0;
      rst <= rst_p;
    end
  end
endmodule