module a_dff(clk, aclr, ena, data, q);
  parameter WIDTH = 8;
  input clk, aclr, ena; 
  input [WIDTH-1:0] data;
  output reg [WIDTH-1:0] q;
  always @ (posedge clk or posedge aclr)
  begin
    if (aclr)
      q <= 1'b0;
    else if (ena)
      q <= data;
  end
endmodule