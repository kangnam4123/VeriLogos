module RSTGEN_2(CLK, RST_X_I, RST_X_O);
    input  CLK, RST_X_I;
    output RST_X_O;
    reg [23:0] cnt;
    assign RST_X_O = cnt[23];
    always @(posedge CLK or negedge RST_X_I) begin
        if      (!RST_X_I) cnt <= 0;
        else if (~RST_X_O) cnt <= (cnt + 1'b1);
    end
endmodule