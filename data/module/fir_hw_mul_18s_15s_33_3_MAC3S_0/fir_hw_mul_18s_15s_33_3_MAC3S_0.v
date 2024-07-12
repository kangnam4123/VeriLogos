module fir_hw_mul_18s_15s_33_3_MAC3S_0(clk, ce, a, b, p);
input clk;
input ce;
input[18 - 1 : 0] a; 
input[15 - 1 : 0] b; 
output[33 - 1 : 0] p;
reg signed [18 - 1 : 0] a_reg0;
reg signed [15 - 1 : 0] b_reg0;
wire signed [33 - 1 : 0] tmp_product;
reg signed [33 - 1 : 0] buff0;
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