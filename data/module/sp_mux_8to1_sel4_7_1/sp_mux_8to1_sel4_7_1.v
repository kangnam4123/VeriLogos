module sp_mux_8to1_sel4_7_1 #(
parameter
    ID                = 0,
    NUM_STAGE         = 1,
    din1_WIDTH       = 32,
    din2_WIDTH       = 32,
    din3_WIDTH       = 32,
    din4_WIDTH       = 32,
    din5_WIDTH       = 32,
    din6_WIDTH       = 32,
    din7_WIDTH       = 32,
    din8_WIDTH       = 32,
    din9_WIDTH         = 32,
    dout_WIDTH            = 32
)(
    input  [6 : 0]     din1,
    input  [6 : 0]     din2,
    input  [6 : 0]     din3,
    input  [6 : 0]     din4,
    input  [6 : 0]     din5,
    input  [6 : 0]     din6,
    input  [6 : 0]     din7,
    input  [6 : 0]     din8,
    input  [3 : 0]    din9,
    output [6 : 0]   dout);
wire [3 : 0]     sel;
wire [6 : 0]         mux_1_0;
wire [6 : 0]         mux_1_1;
wire [6 : 0]         mux_1_2;
wire [6 : 0]         mux_1_3;
wire [6 : 0]         mux_2_0;
wire [6 : 0]         mux_2_1;
wire [6 : 0]         mux_3_0;
wire [6 : 0]         mux_4_0;
assign sel = din9;
assign mux_1_0 = (sel[0] == 0)? din1 : din2;
assign mux_1_1 = (sel[0] == 0)? din3 : din4;
assign mux_1_2 = (sel[0] == 0)? din5 : din6;
assign mux_1_3 = (sel[0] == 0)? din7 : din8;
assign mux_2_0 = (sel[1] == 0)? mux_1_0 : mux_1_1;
assign mux_2_1 = (sel[1] == 0)? mux_1_2 : mux_1_3;
assign mux_3_0 = (sel[2] == 0)? mux_2_0 : mux_2_1;
assign mux_4_0 = mux_3_0;
assign dout = mux_4_0;
endmodule