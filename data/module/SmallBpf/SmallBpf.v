module SmallBpf #(
    parameter WIDTH        = 16, 
    parameter K0_SHIFT     = 10, 
    parameter K1_SHIFT     = 18, 
    parameter CLAMP        = 1   
)
(
    input  clk,                       
    input  rst,                       
    input  en,                        
    input  signed [WIDTH-1:0] dataIn, 
    output signed [WIDTH-1:0] dataOut 
);
reg signed [WIDTH+K0_SHIFT-1:0] acc0;
reg signed [WIDTH+K1_SHIFT-1:0] acc1;
reg signed [WIDTH+1:0] forwardIn;
wire signed [WIDTH-1:0] feedbackOut;
wire signed [WIDTH+K0_SHIFT:0] acc0In;
wire signed [WIDTH+K1_SHIFT:0] acc1In;
assign acc0In = acc0 + forwardIn;
assign acc1In = acc1 + dataOut;
always @(posedge clk) begin
    if (rst) begin
        forwardIn <= 'd0;
        acc0      <= 'd0;
        acc1      <= 'd0;
    end
    else if (en) begin
        forwardIn <= dataIn - dataOut - feedbackOut;
        if (CLAMP) begin
            acc0 <= (^acc0In[WIDTH+K0_SHIFT-:2])
                  ? {acc0In[WIDTH+K0_SHIFT], {(WIDTH+K0_SHIFT-1){acc0In[WIDTH+K0_SHIFT-1]}}}
                  : acc0In;
            acc1 <= (^acc1In[WIDTH+K1_SHIFT-:2])
                  ? {acc1In[WIDTH+K1_SHIFT], {(WIDTH+K1_SHIFT-1){acc1In[WIDTH+K1_SHIFT-1]}}}
                  : acc1In;
        end
        else begin
            acc0 <= acc0In;
            acc1 <= acc1In;
        end
    end
end
assign dataOut     = acc0 >>> K0_SHIFT;
assign feedbackOut = acc1 >>> K1_SHIFT;
endmodule