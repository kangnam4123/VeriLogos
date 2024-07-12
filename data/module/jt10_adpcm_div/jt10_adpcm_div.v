module jt10_adpcm_div #(parameter dw=16)(
    input               rst_n,
    input               clk,    
    input               cen,
    input               start,  
    input      [dw-1:0] a,
    input      [dw-1:0] b,
    output reg [dw-1:0] d,
    output reg [dw-1:0] r,
    output              working
);
reg  [dw-1:0] cycle;
assign working = cycle[0];
wire [dw:0] sub = { r[dw-2:0], d[dw-1] } - b;  
always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        cycle <= 'd0;
    end else if(cen) begin
        if( start ) begin
            cycle <= ~16'd0;
            r     <=  16'd0;
            d     <= a;
        end else if(cycle[0]) begin
            cycle <= { 1'b0, cycle[dw-1:1] };
            if( sub[dw] == 0 ) begin
                r <= sub[dw-1:0];
                d <= { d[dw-2:0], 1'b1};
            end else begin
                r <= { r[dw-2:0], d[dw-1] };
                d <= { d[dw-2:0], 1'b0 };
            end
        end
    end
endmodule