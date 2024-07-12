module opndrn (in, out);
    input in;
    output out;
    bufif0 (out, in, in);
endmodule