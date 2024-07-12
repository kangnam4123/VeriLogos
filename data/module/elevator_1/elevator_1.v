module elevator_1 (
    clk,
    reset,
    en,
    F,
    D,
    Q,
    A,
    B,
    A_latch,
    B_latch,
    LED
);
input clk;
input reset;
input en;
input [3:0] F;
output [3:0] D;
wire [3:0] D;
output [3:0] Q;
reg [3:0] Q;
output A;
reg A;
output B;
reg B;
output A_latch;
reg A_latch;
output B_latch;
reg B_latch;
output [3:0] LED;
wire [3:0] LED;
always @(en, F) begin: ELEVATOR_ENCODER
    if (((F != 0) && en)) begin
        A = ((F[3] || (F[1] && (!F[2]))) != 0);
        B = ((F[2] || F[3]) != 0);
    end
end
always @(reset, A, B, en, F) begin: ELEVATOR_LATCH
    if (reset) begin
        A_latch = (1'b0 != 0);
        B_latch = (1'b0 != 0);
    end
    else if (((F != 0) && en)) begin
        A_latch = A;
        B_latch = B;
    end
end
assign D = {((((!Q[3]) && (!Q[2]) && (!Q[1]) && (!Q[0]) && B_latch && A_latch) || ((!Q[3]) && (!Q[2]) && Q[1] && (!Q[0]) && (!B_latch) && (!A_latch)) || (Q[3] && Q[2] && Q[1] && (!Q[0])) || ((!Q[3]) && (!Q[2]) && Q[1] && Q[0] && (!B_latch))) != 0), ((((!Q[3]) && (!Q[2]) && Q[1] && Q[0] && (!B_latch) && (!A_latch)) || ((!Q[3]) && (!Q[2]) && (!Q[1]) && B_latch && A_latch) || (Q[3] && Q[2] && (!Q[1]) && Q[0]) || ((!Q[3]) && (!Q[2]) && (!Q[1]) && (!Q[0]) && B_latch)) != 0), ((((!Q[3]) && (!Q[2]) && Q[1] && Q[0] && (!B_latch)) || ((!Q[3]) && (!Q[2]) && Q[0] && B_latch) || (Q[2] && (!Q[1]) && Q[0]) || ((!Q[3]) && Q[1] && (!Q[0]) && B_latch) || ((!Q[3]) && Q[2] && Q[1] && (!Q[0]))) != 0), ((((!Q[3]) && (!Q[2]) && Q[1] && (!Q[0]) && (!B_latch) && (!A_latch)) || ((!Q[3]) && (!Q[2]) && (!Q[1]) && (!B_latch) && A_latch) || ((!Q[3]) && (!Q[2]) && Q[1] && B_latch && A_latch) || ((!Q[3]) && (!Q[2]) && (!Q[1]) && (!Q[0]) && B_latch) || (Q[3] && Q[1] && (!Q[0])) || ((!Q[3]) && Q[2] && Q[1] && (!Q[0])) || (Q[1] && (!Q[0]) && A_latch)) != 0)};
always @(posedge clk, posedge reset) begin: ELEVATOR_DFF
    if (reset == 1) begin
        Q <= 0;
    end
    else begin
        if (en) begin
            Q <= D;
        end
    end
end
assign LED = {((Q[1] && Q[0]) != 0), ((Q[1] && (!Q[0])) != 0), (((!Q[1]) && Q[0]) != 0), (((!Q[1]) && (!Q[0])) != 0)};
endmodule