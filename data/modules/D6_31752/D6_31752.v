module D6_31752(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [3:0] addr;
   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h4000;
      1: out3 <= 16'h3ec5;
      2: out3 <= 16'h3b21;
      3: out3 <= 16'h3537;
      4: out3 <= 16'h2d41;
      5: out3 <= 16'h238e;
      6: out3 <= 16'h187e;
      7: out3 <= 16'hc7c;
      8: out3 <= 16'h0;
      9: out3 <= 16'hf384;
      10: out3 <= 16'he782;
      11: out3 <= 16'hdc72;
      12: out3 <= 16'hd2bf;
      13: out3 <= 16'hcac9;
      14: out3 <= 16'hc4df;
      15: out3 <= 16'hc13b;
      default: out3 <= 0;
   endcase
   end
endmodule