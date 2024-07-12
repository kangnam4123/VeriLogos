module counters_mod_nocarry_rtl(
  clk, clk_ena, rst, 
  q);
  parameter ADDR_MOD = 9;
  parameter ADDR_WIDTH = 9;
  input clk, clk_ena, rst;
  output [ADDR_WIDTH-1:0] q;
  reg [ADDR_WIDTH-1:0] cnt;
  reg carry_tmp;
  always @ (posedge clk or posedge rst)
    begin
    if(rst)
      cnt <= 0;
    else if(clk_ena)
      if(carry_tmp)
    cnt <= 0;
   else
      cnt <= cnt + 1;  
  end
  always @ (cnt)
    begin
    if(cnt == ADDR_MOD-1)
      carry_tmp = 'b1;
    else 
      carry_tmp = 'b0;  
  end
  assign q = cnt;
endmodule