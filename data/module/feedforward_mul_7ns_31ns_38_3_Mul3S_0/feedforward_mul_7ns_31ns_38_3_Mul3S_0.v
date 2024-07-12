module feedforward_mul_7ns_31ns_38_3_Mul3S_0(clk, ce, a, b, p);
input clk;
input ce;
input[7 - 1 : 0] a; 
input[31 - 1 : 0] b; 
output[38 - 1 : 0] p;
reg [7 - 1 : 0] a_reg0;
reg [31 - 1 : 0] b_reg0;
wire [38 - 1 : 0] tmp_product;
reg [38 - 1 : 0] buff0;
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