module jt10_cen_burst #(parameter cntmax=3'd6, cntw=3)(
    input           rst_n,
    input           clk,
    input           cen,      
    input           start,
    input           start_cen,
    output          cen_out
);
reg [cntw-1:0] cnt;
reg last_start;
reg pass;
always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        cnt  <= {cntw{1'b1}};
        pass <= 1'b0;
    end else if(cen) begin
        last_start <= start;
        if( start && start_cen ) begin
            cnt  <= 'd0;
            pass <= 1'b1;
        end else begin
            if(cnt != cntmax ) cnt <= cnt+1;
            else pass <= 1'b0;
        end
    end
reg pass_negedge;
assign cen_out = cen & pass_negedge;
always @(negedge clk) begin
    pass_negedge <= pass;
end
endmodule