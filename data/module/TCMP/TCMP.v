module TCMP(clk, rst, a, s);
    input clk, rst;
    input a;
    output reg s;
    reg z;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            s <= 1'b0;
            z <= 1'b0;
        end
        else begin
            z <= a | z;
            s <= a ^ z;
        end
    end
endmodule