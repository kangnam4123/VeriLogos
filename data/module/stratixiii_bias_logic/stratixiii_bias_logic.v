module stratixiii_bias_logic (
    clk,
    shiftnld,
    captnupdt,
    mainclk,
    updateclk,
    capture,
    update
    );
input  clk;
input  shiftnld;
input  captnupdt;
output mainclk;
output updateclk;
output capture;
output update;
reg mainclk_tmp;
reg updateclk_tmp;
reg capture_tmp;
reg update_tmp;
initial
begin
    mainclk_tmp <= 'b0;
    updateclk_tmp <= 'b0;
    capture_tmp <= 'b0;
    update_tmp <= 'b0;
end
    always @(captnupdt or shiftnld or clk)
    begin
        case ({captnupdt, shiftnld})
        2'b10, 2'b11 :
            begin
                mainclk_tmp <= 'b0;
                updateclk_tmp <= clk;
                capture_tmp <= 'b1;
                update_tmp <= 'b0;
            end
        2'b01 :
            begin
                mainclk_tmp <= 'b0;
                updateclk_tmp <= clk;
                capture_tmp <= 'b0;
                update_tmp <= 'b0;
            end
        2'b00 :
            begin
                mainclk_tmp <= clk;
                updateclk_tmp <= 'b0;
                capture_tmp <= 'b0;
                update_tmp <= 'b1;
            end
        default :
            begin
                mainclk_tmp <= 'b0;
                updateclk_tmp <= 'b0;
                capture_tmp <= 'b0;
                update_tmp <= 'b0;
            end
        endcase
    end
and (mainclk, mainclk_tmp, 1'b1);
and (updateclk, updateclk_tmp, 1'b1);
and (capture, capture_tmp, 1'b1);
and (update, update_tmp, 1'b1);
endmodule