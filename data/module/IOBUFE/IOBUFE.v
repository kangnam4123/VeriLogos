module IOBUFE(input I, input E, output O, inout IO);
    assign O = IO;
    assign IO = E ? I : 1'bz;
endmodule