module jtframe_cen3p57(
    input      clk,       
    output reg cen_3p57,
    output reg cen_1p78
);
wire [10:0] step=11'd105;
wire [10:0] lim =11'd1408;
wire [10:0] absmax = lim+step;
reg  [10:0] cencnt=11'd0;
reg  [10:0] next;
reg  [10:0] next2;
always @(*) begin
    next  = cencnt+11'd105;
    next2 = next-lim;
end
reg alt=1'b0;
always @(posedge clk) begin
    cen_3p57 <= 1'b0;
    cen_1p78 <= 1'b0;
    if( cencnt >= absmax ) begin
        cencnt <= 11'd0;
        alt    <= 1'b0;
    end else
    if( next >= lim ) begin
        cencnt <= next2;
        cen_3p57 <= 1'b1;
        alt    <= ~alt;
        if( alt ) cen_1p78 <= 1'b1;
    end else begin
        cencnt <= next;
    end
end
endmodule