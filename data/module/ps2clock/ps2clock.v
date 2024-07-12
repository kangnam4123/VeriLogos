module ps2clock (
    input clk,
    input i_clock,
    output o_clock
);
    reg [10:0] delay_timer = 0;
    reg run_delay_timer = 0;
    reg r_clk = 0;
    assign o_clock = r_clk;
    always @(i_clock) begin
        if (!i_clock) begin
            run_delay_timer <= 1;
        end else begin
            run_delay_timer <= 0;
        end
    end
    always @(posedge clk) begin
        if (run_delay_timer) begin
            delay_timer <= delay_timer + 11'b1;
        end else begin
            delay_timer <= 0;
        end
    end
    always @(posedge clk) begin
        if (delay_timer == 11'd1000) begin
            r_clk <= 0; 
        end else if (delay_timer == 11'd0) begin
            r_clk <= 1;
        end
    end
endmodule