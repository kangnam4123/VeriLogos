module SRAM1RW64x32 (
  input [6:0] A,
  input CE,
  input WEB,
  input OEB,
  input CSB,
  input [31:0] I,
  output reg [31:0] O
);
reg [31:0] ram [63:0];
always @(posedge CE) begin
  if (~CSB) begin
    if (~WEB) begin
      ram[A] <= I;
    end
    if (~OEB) begin
      O <= ram[A];
    end
  end
end
endmodule