module BUFGSR(I, O);
    parameter INVERT = 0;
    input I;
    output O;
    assign O = INVERT ? ~I : I;
endmodule