module D12_31470(addr, out, clk);
   input clk;
   output [15:0] out;
   reg [15:0] out, out2, out3;
   input [2:0] addr;
   always @(posedge clk) begin
      out2 <= out3;
      out <= out2;
   case(addr)
      0: out3 <= 16'h0;
      1: out3 <= 16'he782;
      2: out3 <= 16'hd2bf;
      3: out3 <= 16'hc4df;
      4: out3 <= 16'hc000;
      5: out3 <= 16'hc4df;
      6: out3 <= 16'hd2bf;
      7: out3 <= 16'he782;
      default: out3 <= 0;
   endcase
   end
endmodule