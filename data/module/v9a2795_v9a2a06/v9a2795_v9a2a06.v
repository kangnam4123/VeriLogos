module v9a2795_v9a2a06 (
 input [2:0] i,
 output o2,
 output o1,
 output o0
);
 assign o2 = i[2];
 assign o1 = i[1];
 assign o0 = i[0];
endmodule