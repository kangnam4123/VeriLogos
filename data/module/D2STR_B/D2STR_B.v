module D2STR_B#
    (
    parameter integer len = 16 
    )
    (
        output wire [127:0] str,
        input wire [len-1:0] d
    );
    genvar i;
    generate
    for (i = 0; i < len; i = i + 1) begin
        assign str[8*i+7:8*i] = d[i]? "1" : "0";
    end
    for (i = len; i < 16; i = i + 1) begin
        assign str[8*i+7:8*i] = " ";
    end
    endgenerate
endmodule