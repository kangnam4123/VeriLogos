module delay_3
#(
    parameter DELAY = 128
)
(
    input       clk_i,
    input       rst_n_i,
    input       sig_i,
    output reg  sig_o
);
reg [DELAY-1:0] shift_reg;
always @(posedge clk_i)
begin
    if(rst_n_i == 0)
    begin
        shift_reg   <= 0;
        sig_o       <= 0;
    end
    else
    begin
        shift_reg   <= {shift_reg[DELAY-2:0], sig_i};
        sig_o       <= shift_reg[DELAY-1];
    end
end
endmodule