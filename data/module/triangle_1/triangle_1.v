module triangle_1 #(parameter CTR_SIZE = 8) (
    input  clk,
    input  rst,
    input  [CTR_SIZE-1:0] invslope,
    output [CTR_SIZE-1:0] out
    );
reg out_d, out_q;
reg [CTR_SIZE-1:0] ctr_d, ctr_q;
reg [CTR_SIZE-1:0] dir_d, dir_q;
assign out = out_q;
always@(ctr_q) begin
    ctr_d = ctr_q + 1'b1;
end
always@(*) begin
    if (ctr_q > invslope) begin
        out_d = out_q + dir_q;  
        ctr_q = 1'b0;           
    end
    if (out_d == {CTR_SIZE{1'b1}} || out_d == {CTR_SIZE{1'b0}}) begin
        dir_d = ~dir_d;        
    end
end
always@(posedge clk) begin
    if (rst) begin
        ctr_q <= 1'b0;
        dir_q <= 1'b1;
    end else begin
        ctr_q <= ctr_d;
        dir_q <= dir_d;
    end
    out_q <= out_d;
end
endmodule