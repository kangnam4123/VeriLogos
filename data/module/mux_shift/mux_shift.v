module mux_shift
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
    wire [C_WIDTH*C_NUM_INPUTS-1:0]     wMuxInputs;
    assign wMuxInputs = MUX_INPUTS >> MUX_SELECT;   
    assign MUX_OUTPUT = wMuxInputs[C_WIDTH-1:0];
endmodule