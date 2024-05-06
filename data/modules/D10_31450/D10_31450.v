module D10_31450(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [2:0] addr;
   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3b21;
      2: out3 <= 16'h2d41;
      3: out3 <= 16'h187e;
      4: out3 <= 16'h0;
      5: out3 <= 16'he782;
      6: out3 <= 16'hd2bf;
      7: out3 <= 16'hc4df;
      default: out3 <= 0;
   endcase
   end
endmodule