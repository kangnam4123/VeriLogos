module v78be07_v9a2a06 (
 input [7:0] i,
 output o1,
 output [6:0] o0
);
 assign o1 = i[7];
 assign o0 = i[6:0];
endmodule