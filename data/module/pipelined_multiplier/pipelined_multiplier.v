module pipelined_multiplier #(parameter WL=32)(
    input wire CLK,
    input wire [WL-1:0] A,
    input wire [WL-1:0] B,
    output reg [(WL-1) * 2:0] Out
        );
    reg [(WL-1):0] a_in, b_in;
    wire [(WL-1) * 2:0] multi_reg;
    reg [(WL-1) * 2:0] pipe1, pipe2, pipe3, pipe4, pipe5;
    assign multi_reg = a_in * b_in;
    always @(posedge CLK) begin
            a_in <= A; b_in <= B;
            pipe1 <= multi_reg;
            pipe2 <= pipe1;
            pipe3 <= pipe2;
            pipe4 <= pipe3;
            pipe5 <= pipe4;
            Out <= pipe5;
    end
    endmodule