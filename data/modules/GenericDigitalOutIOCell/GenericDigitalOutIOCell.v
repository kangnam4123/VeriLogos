module GenericDigitalOutIOCell(
    output pad,
    input o,
    input oe
);
    assign pad = oe ? o : 1'bz;
endmodule