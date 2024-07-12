module ClkRecoverSetCounter #(
    parameter TARGET_PERIOD = 10 
)
(
    input clk,        
    input rst,        
    input rx,         
    output reg clkStrobe, 
    output reg rxClocked  
);
parameter PHASE_HIGH = $clog2(TARGET_PERIOD-1) - 1;
wire intClk; 
reg [PHASE_HIGH:0] phaseAccum; 
reg intClkD1; 
reg rxD1;     
reg started;  
wire refClk;
reg isZero;
assign refClk = (phaseAccum == 'd0) && ~isZero;
always @(posedge clk) begin
    isZero <= phaseAccum == 'd0;
end
assign intClk = (phaseAccum == (TARGET_PERIOD>>1));
always @(posedge clk) begin
    rxD1 <= rx;
    intClkD1  <= intClk;
    clkStrobe <= intClk & ~intClkD1;
    rxClocked <= (intClk & ~intClkD1) ? rx : rxClocked;
end
always @(posedge clk) begin
    if (rst) begin
        phaseAccum <= 'd0;
        started    <= 1'b0;
    end
    else begin
        if (started) begin
            if ((rxD1 ^ rx) && (phaseAccum >= (TARGET_PERIOD>>1))) begin
                if (phaseAccum == TARGET_PERIOD-1) begin
                    phaseAccum <= 'd1;
                end
                else if (phaseAccum == TARGET_PERIOD-2) begin
                    phaseAccum <= 'd0;
                end
                else begin
                    phaseAccum <= phaseAccum + 2'd2;
                end
            end
            else if ((rxD1 ^ rx) && (phaseAccum != 'd0)) begin
                phaseAccum <= phaseAccum;
            end
            else if (phaseAccum == TARGET_PERIOD-1) begin
                phaseAccum <= 'd0;
            end
            else begin
                phaseAccum <= phaseAccum + 2'd1;
            end
        end
        else begin
            started <= rxD1 ^ rx;
            phaseAccum <= 'd0;
        end
    end
end
endmodule