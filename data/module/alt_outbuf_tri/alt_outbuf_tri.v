module alt_outbuf_tri (i, oe, o);
    input i;
    input oe;
    output o;
    parameter io_standard = "NONE";
    parameter current_strength = "NONE";
    parameter current_strength_new = "NONE";
    parameter slew_rate = -1;
    parameter slow_slew_rate = "NONE";
    parameter location = "NONE";
    parameter enable_bus_hold = "NONE";
    parameter weak_pull_up_resistor = "NONE"; 
    parameter termination = "NONE"; 
    parameter lpm_type = "alt_outbuf_tri";
    bufif1 (o, i, oe);
endmodule