module scff(
    output reg Q,
    input D,
    input clk
);
    parameter [0:0] INIT = 1'b0;
    initial Q = INIT;
    always @(posedge clk)
            Q <= D;
endmodule