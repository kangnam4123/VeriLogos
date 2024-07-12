module top_245
(
input  wire clk,
input  wire rx,
output wire tx,
input  wire [15:0] sw,
output wire [15:0] led,
input  wire jc1,
inout  wire jc2,
output wire jc3,
input  wire jc4  
);
wire io_i;
wire io_o;
wire io_t;
assign io_o = jc2;
assign jc2  = (io_t == 1'b0) ? io_i : 1'bz;
assign io_i = sw[0];
assign io_t = sw[1];
assign jc3  = sw[2];
assign led[0] = io_o;
assign led[1] = jc1;
assign led[15:2] = {sw[15:3], 1'd0};
endmodule