module dso_trig(nrst, clk, wave_trig, wave_bypass, la_trig, ext_trig, ext_bypass,
                trig_clr, trig_sta, trig_pluse);
    input nrst;
    input clk;
    input wave_trig;
    input wave_bypass;
    input la_trig;
    input ext_trig;
    input ext_bypass;
    input trig_clr;
    output trig_sta;
    output trig_pluse;
    reg trig_sta;
    reg trig_last;
    wire trig_cap;
    assign trig_cap = (wave_trig | wave_bypass) & (ext_trig | ext_bypass) & la_trig;
    assign trig_pluse = trig_sta & ~trig_last;
    always @(posedge clk or negedge nrst) begin
        if (~nrst) begin
            trig_sta <= 1'b0;
        end else if (trig_clr) begin
            trig_sta <= 1'b0;
        end else if (trig_cap) begin
            trig_sta <= 1'b1;
        end
    end
    always @(posedge clk or negedge nrst) begin
        if (~nrst) begin
            trig_last <= 1'b0;
        end else begin
            trig_last <= trig_sta;
        end
    end
endmodule