module Moore_FSM(
    input clk,
    input reset,
    input [1:0] x,
    output reg yout
    );
    reg [2:0] state, nextState;
    parameter s0 = 0, a0 = 1, a1 = 2, b0 = 3, b1 = 4, t0 = 5, t1 = 6;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= s0;
        end
        else begin
            state <= nextState;
        end
    end
    always @(x or state) begin
        case (state)
            s0: begin
                case (x)
                    0: nextState <= s0;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end
            a0: begin
                case (x)
                    0: nextState <= a1;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end
            a1: begin
                case (x)
                    0: nextState <= a1;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end
            b0: begin
                case (x)
                    0: nextState <= b1;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end
            b1: begin
                case (x)
                    0: nextState <= b1;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end
            t0: begin
                case (x)
                    0: nextState <= t1;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end
            t1: begin
                case (x)
                    0: nextState <= t1;
                    1: nextState <= a0;
                    2: nextState <= t0;
                    3: nextState <= b0;
                endcase
            end       
        endcase
    end
    always @(state) begin
        case (state)
            s0, a1: yout <= 0;
            a0, b0, t0: yout <= yout;
            b1: yout <= 1;
            t1: yout <= ~yout;
        endcase
    end
endmodule