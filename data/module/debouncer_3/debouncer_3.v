module debouncer_3
#(
    parameter DEBOUNCER_LEN = 4
)
(
    input       clk_i,
    input       rst_i,
    input       sig_i,
    output reg  sig_o
);
reg [DEBOUNCER_LEN-1:0] shift_reg;
always @(posedge clk_i)
begin
    if(rst_i == 1)
    begin
        shift_reg   <= 0;
        sig_o       <= 0;
    end
    else
    begin
        shift_reg <= {shift_reg[DEBOUNCER_LEN-2:0], sig_i};
        if(shift_reg == {DEBOUNCER_LEN{1'b1}})
        begin
            sig_o <= 1'b1;
        end
        else if(shift_reg == {DEBOUNCER_LEN{1'b0}})
        begin
            sig_o <= 1'b0;
        end
    end
end
endmodule