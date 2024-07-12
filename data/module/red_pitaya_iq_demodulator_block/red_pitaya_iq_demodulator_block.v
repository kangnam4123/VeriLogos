module red_pitaya_iq_demodulator_block #(
    parameter     INBITS   = 14,
    parameter     OUTBITS   = 18,
    parameter     SINBITS   = 14,
    parameter     SHIFTBITS  = 1
)
(
    input clk_i,
    input signed  [SINBITS-1:0] sin, 
    input signed  [SINBITS-1:0] cos, 
    input signed  [INBITS-1:0]  signal_i,
    output signed [OUTBITS-1:0] signal1_o,            
    output signed [OUTBITS-1:0] signal2_o            
);
reg signed [INBITS-1:0] firstproduct_reg;
always @(posedge clk_i) begin
    firstproduct_reg <= signal_i;
end
reg signed [SINBITS+INBITS-1:0] product1;
reg signed [SINBITS+INBITS-1:0] product2;
always @(posedge clk_i) begin
    product1 <= firstproduct_reg * sin + $signed(1 << (SINBITS+INBITS-OUTBITS-SHIFTBITS-1));
    product2 <= firstproduct_reg * cos + $signed(1 << (SINBITS+INBITS-OUTBITS-SHIFTBITS-1));
end
assign signal1_o = product1[SINBITS+INBITS-1-SHIFTBITS:SINBITS+INBITS-OUTBITS-SHIFTBITS];
assign signal2_o = product2[SINBITS+INBITS-1-SHIFTBITS:SINBITS+INBITS-OUTBITS-SHIFTBITS];
endmodule