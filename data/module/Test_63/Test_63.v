module Test_63 (
   outa, outb, outc,
   clk, in
   );
   input clk;
   input [15:0]      in;
   output reg [15:0] outa;
   output reg [15:0] outb;
   output reg [15:0] outc;
   parameter WIDTH = 0;
   always @(posedge clk) begin
      outa <= {in};
      outb <= {{WIDTH{1'b0}}, in};
      outc <= {in, {WIDTH{1'b0}}};
   end
endmodule