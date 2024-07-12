module gprs(
        input           iCLK,
        input           iWRGPR,
        input  [7:0]    iGPRDI,
        input  [3:0]    iSREGA,
        input  [3:0]    iSREGB,
        output          oAZERO,
        output [7:0]    oDATAA,
        output [7:0]    oDATAB
    );
    reg [7:0]       rGPRS[7:0];
    integer k;
    initial
    begin
        for (k = 0; k < 8 ; k = k + 1) begin : init_rGPRS
            rGPRS[k] = 8'h00;
        end
    end
    assign oDATAA = rGPRS[iSREGA];
    assign oDATAB = rGPRS[iSREGB];
    assign oAZERO = oDATAA == 8'h00;
    always@(posedge iCLK) begin
        if(iWRGPR) begin
            rGPRS[iSREGA] <= iGPRDI;
        end
    end
endmodule