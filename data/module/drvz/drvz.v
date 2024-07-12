module  drvz( clk, iA, iC, ioS );
    input   clk, iA, iC ;
    inout   ioS ;
    assign  ioS = (iC) ? iA : 'bz ;
endmodule