module TRI (in, oe, out);
    input in;
    input oe;
    output out;
    bufif1 (out, in, oe);
endmodule