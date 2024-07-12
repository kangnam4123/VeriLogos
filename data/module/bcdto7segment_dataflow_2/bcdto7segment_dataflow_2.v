module bcdto7segment_dataflow_2(
    input [3:0] x,
    output [6:0] seg
    );
    assign seg[6] = (x[2]&(~x[1])&(~x[0]))|((~x[3])&(~x[2])&(~x[1])&x[0]);
    assign seg[5] = (x[2]&(~x[1])&x[0])|(x[2]&x[1]&(~x[0]));
    assign seg[4] = (~x[3])&(~x[2])&x[1]&(~x[0]);
    assign seg[3] = (x[2]&(~x[1])&(~x[0]))|(x[2]&x[1]&x[0])|((~x[3])&(~x[2])&(~x[1])&x[0]);
    assign seg[2] = (x[2]&(~x[1]))|x[0];
    assign seg[1] = (x[1]&x[0])|((~x[3])&(~x[2])&x[0])|((~x[3])&(~x[2])&x[1]);
    assign  seg[0] = ((~x[3])&(~x[2])&(~x[1]))|(x[2]&x[1]&x[0]);
endmodule