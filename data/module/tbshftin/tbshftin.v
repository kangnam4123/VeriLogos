module tbshftin(
  output [7:0] out,
  input sin,
  input clk);
  reg [7:0] register = 8'h00;
  assign out = register;
  always @(posedge clk) begin
    register[7:1] <= register[6:0];
    register[0] = sin; 
  end
endmodule