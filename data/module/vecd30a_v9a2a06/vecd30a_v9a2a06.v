module vecd30a_v9a2a06 (
 input [31:0] i,
 output [30:0] o1,
 output o0
);
 assign o1 = i[31:1];
 assign o0 = i[0];
endmodule