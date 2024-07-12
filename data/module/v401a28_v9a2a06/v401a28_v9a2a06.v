module v401a28_v9a2a06 (
 input [3:0] i3,
 input [3:0] i2,
 input [3:0] i1,
 input [3:0] i0,
 output [15:0] o
);
 assign o = {i3, i2, i1, i0};
endmodule