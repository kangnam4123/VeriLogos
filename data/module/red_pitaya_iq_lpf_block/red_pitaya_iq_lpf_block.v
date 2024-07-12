module red_pitaya_iq_lpf_block #(
    parameter     ALPHABITS = 25,
    parameter     HIGHESTALPHABIT = 18,
    parameter     LPFBITS   = 18 
)
(
    input clk_i,
    input reset_i  ,
    input signed [HIGHESTALPHABIT-1:0] alpha_i, 
    input signed [LPFBITS-1:0] signal_i,
    output signed [LPFBITS-1:0] signal_o
);
reg  signed [LPFBITS+ALPHABITS-1:0]    y;
reg  signed [LPFBITS+ALPHABITS-1:0]    delta;   
wire signed [LPFBITS-1:0]  y_out;
assign y_out = y[ALPHABITS+LPFBITS-1:ALPHABITS];
always @(posedge clk_i) begin
    if (reset_i == 1'b1) begin
        y <=            {ALPHABITS+LPFBITS{1'b0}};
        delta <=        {ALPHABITS+LPFBITS{1'b0}};
    end
    else begin
        delta <= (signal_i-y_out)*alpha_i;
        y <= y + delta;
    end
end
assign signal_o = y_out;
endmodule