module alt_outbuf_tri_diff (i, oe, o, obar);
    input i;
    input oe;
    output o;
    output obar;
    parameter io_standard = "NONE";
    parameter current_strength = "NONE";
    parameter current_strength_new = "NONE";
    parameter slew_rate = -1;
    parameter location = "NONE";
    parameter enable_bus_hold = "NONE";
    parameter weak_pull_up_resistor = "NONE"; 
    parameter termination = "NONE"; 
    parameter lpm_type = "alt_outbuf_tri_diff";
    bufif1 (o, i, oe);
    bufif1 (obar, !i, oe);
endmodule