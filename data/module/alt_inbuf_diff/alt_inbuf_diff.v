module alt_inbuf_diff (i, ibar, o);
    input i;
    input ibar;
    output o;
    parameter io_standard = "NONE";
    parameter location = "NONE";
    parameter enable_bus_hold = "NONE";
    parameter weak_pull_up_resistor = "NONE"; 
    parameter termination = "NONE"; 
    parameter lpm_type = "alt_inbuf_diff";
    reg out_tmp;
    always@(i or ibar)
    begin
        casex({i,ibar})
            2'b00: out_tmp = 1'bx;
            2'b01: out_tmp = 1'b0;
            2'b10: out_tmp = 1'b1;
            2'b11: out_tmp = 1'bx;
            default: out_tmp = 1'bx;
        endcase
    end
    assign o = out_tmp; 
endmodule