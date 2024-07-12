module v2ae6c6_v9a2a06 (
 input [5:0] i1,
 input [1:0] i0,
 output [7:0] o
);
 assign o = {i1, i0};
endmodule