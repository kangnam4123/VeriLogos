module prescaler_2 (clock, reset, div, scaled);
parameter [31:0] SCALE = 28;
input clock;
input reset;
input [1:0] div;
output scaled;
wire scaled = 1'b1;
endmodule