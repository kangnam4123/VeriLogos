module alt_iobuf (i, oe, io, o);
    input i;
    input oe;
    inout io;
    output o;
    reg    o;
    parameter io_standard = "NONE";
    parameter current_strength = "NONE";
    parameter current_strength_new = "NONE";
    parameter slew_rate = -1;
    parameter slow_slew_rate = "NONE";
    parameter location = "NONE";
    parameter enable_bus_hold = "NONE";
    parameter weak_pull_up_resistor = "NONE"; 
    parameter termination = "NONE"; 
    parameter input_termination = "NONE"; 
    parameter output_termination = "NONE";     
    parameter lpm_type = "alt_iobuf";
    always @(io)
    begin
        o = io;
    end
    assign io = (oe == 1) ? i : 1'bz;
endmodule