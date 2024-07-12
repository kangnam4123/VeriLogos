module spirdshft(
  output [7:0] dout,
  input din,
  input clk,
  input en);
  reg [7:0] doutregister = 8'h00;
  assign dout = doutregister;
  always @(posedge clk) begin
    if(en) begin
      doutregister[7:1] <= doutregister[6:0];
      doutregister[0] <= din; 
    end
  end
endmodule