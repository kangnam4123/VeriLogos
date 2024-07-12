module bp_osc #(parameter WIDTH = 8)
             (
              input wire                   clk,
              input wire                   reset_n,
              input wire [(WIDTH - 1) : 0] opa,
              input wire [(WIDTH - 1) : 0] opb,
              output wire                  dout
             );
  reg dout_reg;
  reg [WIDTH : 0] sum;
  reg 	          cin;
  assign dout = dout_reg;
     always @ (posedge clk or negedge reset_n)
       begin
         if (!reset_n)
           begin
             dout_reg <= 1'b0;
           end
         else
           begin
             dout_reg <= cin;
           end
       end
  always @*
    begin: adder_osc
      cin = ~sum[WIDTH];
      sum = opa + opb + cin;
    end
endmodule