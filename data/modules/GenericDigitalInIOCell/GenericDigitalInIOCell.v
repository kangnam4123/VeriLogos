module GenericDigitalInIOCell(
    input pad,
    output i,
    input ie
);
    assign i = ie ? pad : 1'b0;
endmodule