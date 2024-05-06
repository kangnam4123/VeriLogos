module GenericAnalogIOCell(
    inout pad,
    inout core
);
    assign core = 1'bz;
    assign pad = core;
endmodule