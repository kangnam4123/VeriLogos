module rosc #(parameter WIDTH = 2)
             (
              input wire                   clk,
              input wire                   reset_n,
              input wire                   we,
              input wire [(WIDTH - 1) : 0] opa,
              input wire [(WIDTH - 1) : 0] opb,
              output wire                  dout
             );
  reg dout_reg;
  reg dout_new;
  assign dout = dout_reg;
     always @ (posedge clk or negedge reset_n)
       begin
         if (!reset_n)
           begin
             dout_reg <= 1'b0;
           end
         else
           begin
             if (we)
               begin
                 dout_reg <= dout_new;
               end
           end
       end
  always @*
    begin: adder_osc
      reg [WIDTH : 0] sum;
      reg             cin;
      cin = ~sum[WIDTH];
      sum = opa + opb + cin;
      dout_new = sum[WIDTH];
    end
endmodule