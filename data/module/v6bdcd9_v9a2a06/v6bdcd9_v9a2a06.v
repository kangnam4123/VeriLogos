module v6bdcd9_v9a2a06 (
 input [7:0] i,
 output [3:0] o1,
 output [3:0] o0
);
 assign o1 = i[7:4];
 assign o0 = i[3:0];
endmodule