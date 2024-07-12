module SmallHpf2nd #(
    parameter K0_SHIFT = 8, 
    parameter K1_SHIFT = 8, 
    parameter WIDTH = 16,   
    parameter CLAMP = 1     
)
(
    input clk,                        
    input rst,                        
    input en,                         
    input  signed [WIDTH-1:0] dataIn, 
    output signed [WIDTH-1:0] dataOut 
);
reg signed [WIDTH+K0_SHIFT-1:0] acc0;
reg signed [WIDTH+K1_SHIFT-1:0] acc1;
reg signed [WIDTH-1:0] forwardPath;
wire signed [WIDTH-1:0] acc0Out;
wire signed [WIDTH-1:0] acc1Out;
wire signed [WIDTH+K0_SHIFT:0] acc0In;
wire signed [WIDTH+K1_SHIFT:0] acc1In;
assign acc0In = acc0 + dataOut;
assign acc1In = acc1 + acc0Out;
always @(posedge clk) begin
    if (rst) begin
        forwardPath <= 'd0;
        acc0        <= 'd0;
        acc1        <= 'd0;
    end
    else if (en) begin
        forwardPath <= dataIn - acc0Out - acc1Out;
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
assign dataOut = forwardPath;
assign acc0Out = acc0 >>> K0_SHIFT;
assign acc1Out = acc1 >>> K1_SHIFT;
endmodule