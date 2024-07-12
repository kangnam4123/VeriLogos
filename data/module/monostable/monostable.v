module monostable(
        input clk,
        input reset,
        input trigger,
        output reg pulse = 0
);
        parameter PULSE_WIDTH = 0;
        reg [4:0] count = 0;
        wire count_rst = reset | (count == PULSE_WIDTH);
        always @ (posedge trigger, posedge count_rst) begin
                if (count_rst) begin
                        pulse <= 1'b0;
                end else begin
                        pulse <= 1'b1;
                end
        end
        always @ (posedge clk, posedge count_rst) begin
                if(count_rst) begin
                        count <= 0;
                end else begin
                        if(pulse) begin
                                count <= count + 1'b1;
                        end
                end
        end
endmodule