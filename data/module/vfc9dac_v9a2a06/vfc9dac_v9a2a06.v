module vfc9dac_v9a2a06 (
 input [1:0] i,
 output o1,
 output o0
);
 assign o1 = i[1];
 assign o0 = i[0];
endmodule