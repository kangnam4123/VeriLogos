module my_or(C,A,B);
    output C;
    input A,B;
    wire A_out;
    wire B_out;
    nand input_nand1(A_out,A,A);
    nand input_nand2(B_out,B,B);
    nand output_nand(C,A_out,B_out);
endmodule