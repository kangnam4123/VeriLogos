module v91f34c_v9a2a06 (
 input [4:0] i,
 output o1,
 output [3:0] o0
);
 assign o1 = i[4];
 assign o0 = i[3:0];
endmodule