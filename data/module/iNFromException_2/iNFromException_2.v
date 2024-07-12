module
    iNFromException_2#(parameter width = 1) (
        input signedOut,
        input isNaN,
        input sign,
        output [(width - 1):0] out
    );
    assign out = {1'b1, {(width - 1){!signedOut}}};
endmodule