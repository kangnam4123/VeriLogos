module my_video_filter_mul_16ns_32ns_48_3_Mul3S_0(clk, ce, a, b, p);
input clk;
input ce;
input[16 - 1 : 0] a; 
input[32 - 1 : 0] b; 
output[48 - 1 : 0] p;
reg [16 - 1 : 0] a_reg0;
reg [32 - 1 : 0] b_reg0;
wire [48 - 1 : 0] tmp_product;
reg [48 - 1 : 0] buff0;
assign p = buff0;
assign tmp_product = a_reg0 * b_reg0;
always @ (posedge clk) begin
    if (ce) begin
        a_reg0 <= a;
        b_reg0 <= b;
        buff0 <= tmp_product;
    end
end
endmodule