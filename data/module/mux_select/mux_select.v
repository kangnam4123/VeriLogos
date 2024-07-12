module mux_select
    #(
      parameter C_NUM_INPUTS = 4,
      parameter C_CLOG_NUM_INPUTS = 2,
      parameter C_WIDTH = 32
      )
    (
     input [(C_NUM_INPUTS)*C_WIDTH-1:0] MUX_INPUTS,
     input [C_CLOG_NUM_INPUTS-1:0]      MUX_SELECT,
     output [C_WIDTH-1:0]               MUX_OUTPUT
     );
    genvar                              i;
    wire [C_WIDTH-1:0]                  wMuxInputs[C_NUM_INPUTS-1:0];
    assign MUX_OUTPUT = wMuxInputs[MUX_SELECT];
    generate
        for (i = 0; i < C_NUM_INPUTS ; i = i + 1) begin : gen_muxInputs_array
            assign wMuxInputs[i] = MUX_INPUTS[i*C_WIDTH +: C_WIDTH];
        end
    endgenerate
endmodule