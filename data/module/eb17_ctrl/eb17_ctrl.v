module eb17_ctrl #(
    parameter ZERO = 7'b1_0_01_00_0,
    parameter ONE  = 7'b1_1_00_11_0,
    parameter TWO  = 7'b0_1_10_10_1
) (
    input  t_0_req,
    output t_0_ack,
    output i_0_req,
    input  i_0_ack,
    output en0, en1, sel,
    input  clk, reset_n
);
reg [6:0] state, state_nxt;
always @(posedge clk or negedge reset_n)
    if (~reset_n) state <= ZERO;
    else          state <= state_nxt;
always @*
    casez({state, t_0_req, i_0_ack})
        {ZERO, 2'b1?} : state_nxt = ONE;
        {ONE,  2'b01} : state_nxt = ZERO;
        {ONE,  2'b10} : state_nxt = TWO;
        {TWO,  2'b?1} : state_nxt = ONE;
        default         state_nxt = state;
    endcase
assign t_0_ack = state[6];
assign i_0_req = state[5];
assign en0 = (state[4] | t_0_req) & (state[3] | i_0_ack);
assign en1 = (state[2] & t_0_req) & (state[1] ^ i_0_ack);
assign sel = state[0];
endmodule