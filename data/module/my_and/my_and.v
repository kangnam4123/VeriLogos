module my_and(C,A,B); 
    output C;
    input A,B;
    wire W1;
    nand input_nand(W1,A,B);
    nand output_nand(C,W1,W1);
endmodule