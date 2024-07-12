module dio_if(oe, dio, din, dout);
    parameter width = 1;
    input oe;
    inout [width-1:0] dio;
    input [width-1:0] din;
    output [width-1:0] dout;
    assign dout = dio;
    assign dio = oe ? din : {width{1'bz}};
endmodule