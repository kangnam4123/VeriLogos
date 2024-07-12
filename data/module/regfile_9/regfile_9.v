module regfile_9(
    output [31:0] RD1, RD2,
    input [4:0] A1, A2, A3,
    input [31:0] WD3,
    input WE3, clk
    );
    reg [31:0] rf [0:31];
    initial rf[0] = 32'h00000000;
    always @ *                                  
    if (WE3 & (A3 != 5'b00000)) begin
            rf[A3] <= WD3;
        end
    assign RD1 = (A1 != 0) ? rf[A1] : 0;
    assign RD2 = (A2 != 0) ? rf[A2] : 0;
endmodule