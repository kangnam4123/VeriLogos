module Mux_3x1_bv2_1 #(parameter W=32)
(
input wire [1:0] select,
input wire [W-1:0] ch_0,
input wire [W-1:0] ch_1,
input wire [W-1:0] ch_2,
output reg [W-1:0] data_out
);
    always @*
        begin
            case(select)
                2'b00: data_out <= {W{1'b0}};
                2'b01: data_out <= ch_0;
                2'b10: data_out <= ch_1;
                2'b11: data_out <= ch_2;
                default : data_out <= ch_0;
            endcase
        end
endmodule