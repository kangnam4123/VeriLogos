module multiplexor_2x1#(parameter BIT_WIDTH = 32)
                       (input                   control,
                        input[BIT_WIDTH - 1:0]  in0,
                        input[BIT_WIDTH - 1:0]  in1,
                        output[BIT_WIDTH - 1:0] out);
    wire                  neg_control;
    wire[BIT_WIDTH - 1:0] out0;
    wire[BIT_WIDTH - 1:0] out1;
    genvar                i;
    not (neg_control, control);
    generate
        for (i = 0; i < 32; i = i + 1)
        begin : mux_bit
            and (out0[i], neg_control, in0[i]);
            and (out1[i], control, in1[i]);
            or (out[i], out0[i], out1[i]);
        end
    endgenerate
endmodule