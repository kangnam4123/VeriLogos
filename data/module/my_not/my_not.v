module my_not(C,A);
    output C;
    input A;
    nand output_nand(C,A,A);
endmodule