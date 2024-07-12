module FIFO_image_filter_img_0_data_stream_1_V_shiftReg (
    clk,
    data,
    ce,
    a,
    q);
parameter DATA_WIDTH = 32'd8;
parameter ADDR_WIDTH = 32'd1;
parameter DEPTH = 32'd2;
input clk;
input [DATA_WIDTH-1:0] data;
input ce;
input [ADDR_WIDTH-1:0] a;
output [DATA_WIDTH-1:0] q;
reg[DATA_WIDTH-1:0] SRL_SIG [0:DEPTH-1];
integer i;
always @ (posedge clk)
    begin
        if (ce)
        begin
            for (i=0;i<DEPTH-1;i=i+1)
                SRL_SIG[i+1] <= SRL_SIG[i];
            SRL_SIG[0] <= data;
        end
    end
assign q = SRL_SIG[a];
endmodule