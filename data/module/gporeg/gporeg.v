module gporeg(
        input           iCLK,
        input           iWRSFR,
        input  [7:0]    iDTBUS,
        input  [3:0]    iSSFRR,
        output [7:0]    oGPO
    );
    reg [7:0]     rGPO = 8'h00;
    assign oGPO = rGPO;
    always@(posedge iCLK) begin
        if(iWRSFR && (iSSFRR == 4'h01)) begin
            rGPO <= iDTBUS;
        end
        else begin
            rGPO <= rGPO;
        end
    end
endmodule