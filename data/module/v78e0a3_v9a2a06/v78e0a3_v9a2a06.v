module v78e0a3_v9a2a06 (
 input [7:0] i3,
 input [7:0] i2,
 input [7:0] i1,
 input [7:0] i0,
 output [31:0] o
);
 assign o = {i3, i2, i1, i0};
endmodule