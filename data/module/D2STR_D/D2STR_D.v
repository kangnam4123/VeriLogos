module D2STR_D#
    (
    parameter integer len = 4 
    )
    (
        input wire GCLK,
        output reg [127:0] str = "????????????????",
        input wire [4*len-1:0] d
    );
    genvar i;
    generate
    for (i = 0; i < len; i = i + 1) begin: test
        always @(posedge GCLK) begin
            case (d[4*i+3:4*i])
            4'd0: str[8*i+7:8*i] <= "0";
            4'd1: str[8*i+7:8*i] <= "1";
            4'd2: str[8*i+7:8*i] <= "2";
            4'd3: str[8*i+7:8*i] <= "3";
            4'd4: str[8*i+7:8*i] <= "4";
            4'd5: str[8*i+7:8*i] <= "5";
            4'd6: str[8*i+7:8*i] <= "6";
            4'd7: str[8*i+7:8*i] <= "7";
            4'd8: str[8*i+7:8*i] <= "8";
            4'd9: str[8*i+7:8*i] <= "9";
            4'd10: str[8*i+7:8*i] <= " ";
            4'd11: str[8*i+7:8*i] <= " ";
            4'd12: str[8*i+7:8*i] <= " ";
            4'd13: str[8*i+7:8*i] <= " ";
            4'd14: str[8*i+7:8*i] <= " ";
            4'd15: str[8*i+7:8*i] <= "-";
            default: str[8*i+7:8*i] <= " ";
            endcase            
        end
    end
    for (i = len; i < 16; i = i + 1) begin
        always @(posedge GCLK) begin
            str[8*i+7:8*i] <= " ";
        end
    end
    endgenerate
endmodule