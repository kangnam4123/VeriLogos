module Keyboard_driver(clk, reset, ready_pulse, Keyboard_Data, ACK, STB, DAT_O);
    input clk;
    input reset;
    input ready_pulse;
    input [7: 0] Keyboard_Data;
    input STB;
    output ACK;
    output [31: 0] DAT_O;
    reg [31: 0] data_hold = 0;
    reg [7: 0] data_cooked;
    reg [23: 0] data_cnt = 0;
    reg f0 = 0;
    assign DAT_O = {data_cooked, data_cnt};
    assign ACK = STB;
    always @(posedge ready_pulse) begin
        if (Keyboard_Data == 8'hf0)
            f0 <= 1;
        else begin
            if (!f0) begin
                data_hold <= Keyboard_Data;
                data_cnt <= data_cnt + 1;
            end else
                f0 <= 0;
        end
    end
    always @* begin
        case(data_hold)
            8'h16: data_cooked = 49;
            8'h1E: data_cooked = 50;
            8'h26: data_cooked = 51;
            8'h25: data_cooked = 52;
            8'h2E: data_cooked = 53;
            8'h36: data_cooked = 54;
            8'h3D: data_cooked = 55;
            8'h3E: data_cooked = 56;
            8'h46: data_cooked = 57;
            8'h45: data_cooked = 48;
            8'h4E: data_cooked = 45;
            8'h55: data_cooked = 43;
            8'h15: data_cooked = 113;
            8'h1D: data_cooked = 119;
            8'h24: data_cooked = 101;
            8'h2D: data_cooked = 114;
            8'h2C: data_cooked = 116;
            8'h35: data_cooked = 121;
            8'h3C: data_cooked = 117;
            8'h43: data_cooked = 105;
            8'h44: data_cooked = 111;
            8'h4D: data_cooked = 112;
            8'h54: data_cooked = 91;
            8'h5B: data_cooked = 93;
            8'h1C: data_cooked = 97;
            8'h1B: data_cooked = 115;
            8'h23: data_cooked = 100;
            8'h2B: data_cooked = 102;
            8'h34: data_cooked = 103;
            8'h33: data_cooked = 104;
            8'h3B: data_cooked = 106;
            8'h42: data_cooked = 107;
            8'h4B: data_cooked = 108;
            8'h4C: data_cooked = 59;
            8'h52: data_cooked = 92;
            8'h1A: data_cooked = 122;
            8'h22: data_cooked = 120;
            8'h21: data_cooked = 99;
            8'h2A: data_cooked = 118;
            8'h32: data_cooked = 98;
            8'h31: data_cooked = 110;
            8'h3A: data_cooked = 109;
            8'h41: data_cooked = 44;
            8'h49: data_cooked = 46;
            8'h4A: data_cooked = 47;
            8'h29: data_cooked = 32;
            8'h66: data_cooked = 8; 
            8'h5A: data_cooked = 10;
            default: data_cooked = 0;
        endcase
    end
endmodule