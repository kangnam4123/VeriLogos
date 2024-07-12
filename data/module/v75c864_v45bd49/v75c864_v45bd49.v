module v75c864_v45bd49 (
 input i,
 input [2:0] sel,
 output [7:0] o
);
 assign o = i << sel;
endmodule