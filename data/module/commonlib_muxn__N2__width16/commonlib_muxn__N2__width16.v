module commonlib_muxn__N2__width16 (
    input [15:0] in_data_0,
    input [15:0] in_data_1,
    input [0:0] in_sel,
    output [15:0] out
);
assign out = in_sel[0] ? in_data_1 : in_data_0;
endmodule