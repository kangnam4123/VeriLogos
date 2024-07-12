module image_filter_mul_8ns_22ns_30_3_MAC3S_0(clk, ce, a, b, p);
input clk;
input ce;
input[8 - 1 : 0] a; 
input[22 - 1 : 0] b; 
output[30 - 1 : 0] p;
reg [8 - 1 : 0] a_reg0;
reg [22 - 1 : 0] b_reg0;
wire [30 - 1 : 0] tmp_product;
reg [30 - 1 : 0] buff0;
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