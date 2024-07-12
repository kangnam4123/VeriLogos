module v9c1f69_v9a2a06 (
 input [7:0] i,
 output [2:0] o1,
 output [4:0] o0
);
 assign o1 = i[7:5];
 assign o0 = i[4:0];
endmodule