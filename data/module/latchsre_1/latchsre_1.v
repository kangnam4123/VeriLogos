module latchsre_1 (
    output reg Q,
    input S,
    input R,
    input D,
    input G,
    input E
);
    parameter [0:0] INIT = 1'b0;
    parameter [0:0] IS_C_INVERTED = 1'b0;
    initial Q = INIT;
    always @*
            begin
              if (R) Q <= 1'b0;
              if (S) Q <= 1'b1;
            else if (E && G) Q <= D;
    end
endmodule