module qam_dem_top_mul_16s_12s_27_2_MulnS_0(clk, ce, a, b, p);
input clk;
input ce;
input signed [16 - 1 : 0] a; 
input signed [12 - 1 : 0] b; 
output[27 - 1 : 0] p;
reg signed [27 - 1 : 0] p;
wire signed [27 - 1 : 0] tmp_product;
assign tmp_product = $signed(a) * $signed(b);
always @ (posedge clk) begin
    if (ce) begin
        p <= tmp_product;
    end
end
endmodule