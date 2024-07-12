module lcd_2(clk, lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e, sf_ce0);
    parameter k = 15;
    input clk;
    output lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e, sf_ce0;
    reg lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e, sf_ce0;
    reg [k+8-1:0] count;
    reg lcd_busy;
    reg [5:0] lcd_char;
    reg lcd_stb;
    reg [6:0] lcd_intf_signals;
    always @ (posedge clk)
        begin
            count <= count + 1;
            lcd_busy <= 1'b1;
            sf_ce0 <= 1; 
            case (count[k+7:k+2])
                0: lcd_char <= 6'h03; 
                1: lcd_char <= 6'h03;
                2: lcd_char <= 6'h03; 
                3: lcd_char <= 6'h02;
                4: lcd_char <= 6'h02; 
                5: lcd_char <= 6'h08;
                6: lcd_char <= 6'h00; 
                7: lcd_char <= 6'h06;
                8: lcd_char <= 6'h00; 
                9: lcd_char <= 6'h0C;
                10: lcd_char <= 6'h00; 
                11: lcd_char <= 6'h01;
                12: lcd_char <= 6'h24; 
                13: lcd_char <= 6'h28;
                14: lcd_char <= 6'h26; 
                15: lcd_char <= 6'h25;
                16: lcd_char <= 6'h26; 
                17: lcd_char <= 6'h2C;
                18: lcd_char <= 6'h26; 
                19: lcd_char <= 6'h2C;
                20: lcd_char <= 6'h26; 
                21: lcd_char <= 6'h2F;
                22: lcd_char <= 6'h22; 
                23: lcd_char <= 6'h20;
                24: lcd_char <= 6'h25; 
                25: lcd_char <= 6'h23;
                26: lcd_char <= 6'h26; 
                27: lcd_char <= 6'h25;
                28: lcd_char <= 6'h26; 
                29: lcd_char <= 6'h21;
                30: lcd_char <= 6'h26; 
                31: lcd_char <= 6'h2E;
                32: lcd_char <= 6'h22; 
                33: lcd_char <= 6'h21;
                default: lcd_char <= 6'h10;
            endcase
            lcd_stb <= ^count[k+1:k+0] & ~lcd_rw & lcd_busy;
            lcd_intf_signals <= {lcd_stb, lcd_char};
            {lcd_rs, sf_d8, sf_d9, sf_d10, sf_d11, lcd_rw, lcd_e} <= lcd_intf_signals;
        end
endmodule