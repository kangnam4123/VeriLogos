module smallPidController #(
    parameter WIDTH = 16,       
    parameter KP = 0,           
    parameter KI = 0,           
    parameter KD = 0,           
    parameter KI_WIDTH = WIDTH, 
    parameter ENABLE_KP = 1,    
    parameter ENABLE_KI = 1,    
    parameter ENABLE_KD = 0,    
    parameter ENABLE_CLAMP = 0, 
    parameter ENABLE_BLEED = 0  
)
(
    input  wire clk,
    input  wire reset,
    input  wire signed [WIDTH-1:0] inData,
    output reg  signed [WIDTH-1:0] outData
);
wire signed [KI_WIDTH:0] integratorCalc;
reg signed [WIDTH-1:0]    inDataD1;
reg signed [WIDTH:0]      differentiator;
reg signed [KI_WIDTH-1:0] integrator;
always @(posedge clk) begin
    if (reset) begin
        inDataD1       <= 'd0;
        outData        <= 'd0;
        differentiator <= 'd0;
        integrator     <= 'd0;
    end
    else begin
        inDataD1 <= inData;
        outData <= ((ENABLE_KP) ? (inDataD1       >>> KP) : 'd0)
                 + ((ENABLE_KI) ? (integrator     >>> KI) : 'd0) 
                 + ((ENABLE_KD) ? (differentiator >>> KD) : 'd0);
        if (ENABLE_KD) differentiator <= inData - inDataD1;
        else           differentiator <= 'd0;
        if (ENABLE_KI) begin
            if (ENABLE_CLAMP) begin
                integrator <= (^integratorCalc[KI_WIDTH -: 2])
                            ? {integratorCalc[KI_WIDTH], {(KI_WIDTH-1){~integratorCalc[KI_WIDTH]}}}
                            : integratorCalc;
            end
            else begin
                integrator <= integratorCalc;
            end
        end
        else begin
            integrator <= 'd0;
        end
    end
end
endmodule