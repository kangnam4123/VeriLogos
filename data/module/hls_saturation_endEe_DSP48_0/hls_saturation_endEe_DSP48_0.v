module hls_saturation_endEe_DSP48_0(
    input  [20 - 1:0] in0,
    input  [16 - 1:0] in1,
    input  [27 - 1:0] in2,
    output [36 - 1:0]  dout);
wire signed [25 - 1:0]     a;
wire signed [18 - 1:0]     b;
wire signed [48 - 1:0]     c;
wire signed [43 - 1:0]     m;
wire signed [48 - 1:0]     p;
assign a  = $unsigned(in0);
assign b  = $signed(in1);
assign c  = $unsigned(in2);
assign m  = a * b;
assign p  = m + c;
assign dout = p;
endmodule