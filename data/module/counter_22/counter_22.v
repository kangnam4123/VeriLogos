module counter_22 #(parameter W=8, RV={W{1'b0}}) (
    output reg [W-1:0] cnt,
    input  clr,
    input inc,
    input  clk,
    input rst_n
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) cnt <= 0;
        else if (clr) cnt <= 0;
        else if (inc) cnt <= cnt+1'b1;
    end
endmodule