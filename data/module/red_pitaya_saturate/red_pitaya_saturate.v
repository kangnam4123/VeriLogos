module red_pitaya_saturate
#( parameter BITS_IN = 50,
   parameter BITS_OUT = 20,
   parameter SHIFT = 10
)
(
    input signed [BITS_IN-1:0] input_i,
    output signed [BITS_OUT-1:0] output_o,
    output overflow
    );
assign {output_o,overflow} =  ( {input_i[BITS_IN-1],|input_i[BITS_IN-2:SHIFT+BITS_OUT-1]} ==2'b01) ? 
                                                                            {{1'b0,{BITS_OUT-1{1'b1}}},1'b1}  : 
                   ( {input_i[BITS_IN-1],&input_i[BITS_IN-2:SHIFT+BITS_OUT-1]} == 2'b10) ? 
                                                                            {{1'b1,{BITS_OUT-1{1'b0}}},1'b1}  : 
                    {input_i[SHIFT+BITS_OUT-1:SHIFT],1'b0} ; 
endmodule