module red_pitaya_product_sat
#( parameter BITS_IN1 = 50,
   parameter BITS_IN2 = 50,
   parameter BITS_OUT = 50,
   parameter SHIFT = 10
)
(
    input signed [BITS_IN1-1:0] factor1_i,
    input signed [BITS_IN2-1:0] factor2_i,
    output signed [BITS_OUT-1:0] product_o,
    output overflow
    );
wire signed [BITS_IN1+BITS_IN2-1:0] product;
assign product = factor1_i*factor2_i + $signed(1 <<(SHIFT-1));
assign {product_o,overflow} =  ( {product[BITS_IN1+BITS_IN2-1],|product[BITS_IN1+BITS_IN2-2:SHIFT+BITS_OUT-1]} ==2'b01) ? {{1'b0,{BITS_OUT-1{1'b1}}},1'b1}  : 
                    ( {product[BITS_IN1+BITS_IN2-1],&product[BITS_IN1+BITS_IN2-2:SHIFT+BITS_OUT-1]} ==2'b10) ? {{1'b1,{BITS_OUT-1{1'b0}}},1'b1}   : 
                    {product[SHIFT+BITS_OUT-1:SHIFT],1'b0} ; 
endmodule