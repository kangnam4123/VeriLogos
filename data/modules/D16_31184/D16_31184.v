module D16_31184(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [1:0] addr;
   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'hd2bf;
      2: out3 <= 16'hc000;
      3: out3 <= 16'hd2bf;
      default: out3 <= 0;
   endcase
   end
endmodule