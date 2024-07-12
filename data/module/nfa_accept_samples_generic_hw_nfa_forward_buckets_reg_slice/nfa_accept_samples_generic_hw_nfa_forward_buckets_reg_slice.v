module nfa_accept_samples_generic_hw_nfa_forward_buckets_reg_slice
#(parameter
    N = 8   
) (
    input  wire         sclk,
    input  wire         reset_n,
    input  wire [N-1:0] s_data,
    input  wire         s_valid,
    output wire         s_ready,
    output wire [N-1:0] m_data,
    output wire         m_valid,
    input  wire         m_ready
);
localparam [1:0]
    ZERO = 2'b10,
    ONE  = 2'b11,
    TWO  = 2'b01;
reg  [N-1:0] data_p1;
reg  [N-1:0] data_p2;
wire         load_p1;
wire         load_p2;
wire         load_p1_from_p2;
reg          s_ready_t;
reg  [1:0]   state;
reg  [1:0]   next;
assign s_ready = s_ready_t;
assign m_data  = data_p1;
assign m_valid = state[0];
assign load_p1 = (state == ZERO && s_valid) ||
                 (state == ONE && s_valid && m_ready) ||
                 (state == TWO && m_ready);
assign load_p2 = s_valid & s_ready;
assign load_p1_from_p2 = (state == TWO);
always @(posedge sclk) begin
    if (load_p1) begin
        if (load_p1_from_p2)
            data_p1 <= data_p2;
        else
            data_p1 <= s_data;
    end
end
always @(posedge sclk) begin
    if (load_p2) data_p2 <= s_data;
end
always @(posedge sclk) begin
    if (~reset_n)
        s_ready_t <= 1'b0;
    else if (state == ZERO)
        s_ready_t <= 1'b1;
    else if (state == ONE && next == TWO)
        s_ready_t <= 1'b0;
    else if (state == TWO && next == ONE)
        s_ready_t <= 1'b1;
end
always @(posedge sclk) begin
    if (~reset_n)
        state <= ZERO;
    else
        state <= next;
end
always @(*) begin
    case (state)
        ZERO:
            if (s_valid & s_ready)
                next = ONE;
            else
                next = ZERO;
        ONE:
            if (~s_valid & m_ready)
                next = ZERO;
            else if (s_valid & ~m_ready)
                next = TWO;
            else
                next = ONE;
        TWO:
            if (m_ready)
                next = ONE;
            else
                next = TWO;
        default:
            next = ZERO;
    endcase
end
endmodule