module GenericDigitalGPIOCell(
    inout pad,
    output i,
    input ie,
    input o,
    input oe
);
    assign pad = oe ? o : 1'bz;
    assign i = ie ? pad : 1'b0;
endmodule