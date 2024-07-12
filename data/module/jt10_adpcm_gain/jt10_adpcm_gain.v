module jt10_adpcm_gain(
    input           rst_n,
    input           clk,        
    input           cen,        
    input   [5:0]   cur_ch,
    input   [5:0]   en_ch,
    input           match,
    input   [5:0]   atl,        
    input   [7:0]   lracl,
    input   [2:0]   up_ch,
    output  [1:0]   lr,
    input      signed [15:0] pcm_in,
    output     signed [15:0] pcm_att
);
reg [5:0] up_ch_dec;
always @(*)
    case(up_ch)
        3'd0: up_ch_dec = 6'b000_001;
        3'd1: up_ch_dec = 6'b000_010;
        3'd2: up_ch_dec = 6'b000_100;
        3'd3: up_ch_dec = 6'b001_000;
        3'd4: up_ch_dec = 6'b010_000;
        3'd5: up_ch_dec = 6'b100_000;
        default: up_ch_dec = 6'd0;
    endcase
reg  [6:0] db5;
always @(*)
    case( db5[2:0] )
        3'd0: lin_5b = 10'd512;
        3'd1: lin_5b = 10'd470;
        3'd2: lin_5b = 10'd431;
        3'd3: lin_5b = 10'd395;
        3'd4: lin_5b = 10'd362;
        3'd5: lin_5b = 10'd332;
        3'd6: lin_5b = 10'd305;
        3'd7: lin_5b = 10'd280;
    endcase
reg [7:0] lracl1, lracl2, lracl3, lracl4, lracl5, lracl6;
reg  [9:0] lin_5b, lin1, lin2, lin6;
reg [3:0] sh1, sh6;
assign lr = lracl1[7:6];
always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        lracl1  <= 8'd0; lracl2 <= 8'd0;
        lracl3  <= 8'd0; lracl4 <= 8'd0;
        lracl5  <= 8'd0; lracl6 <= 8'd0;
        db5     <= 'd0;
        sh1     <= 4'd0; sh6    <= 4'd0;
        lin1    <= 10'd0;
        lin6    <= 10'd0;
    end else if(cen) begin
        lracl2  <= up_ch_dec == cur_ch ? lracl : lracl1;
        lracl3  <= lracl2;
        lracl4  <= lracl3;
        lracl5  <= lracl4;
        db5     <= { 2'b0, ~lracl4[4:0] } + {1'b0, ~atl};
        lracl6  <= lracl5;
        lin6    <= lin_5b;
        sh6     <= db5[6:3];
        lracl1  <= lracl6;
        lin1    <= sh6[3] ? 10'h0 : lin6;
        sh1     <= sh6;
    end
reg [3:0] shcnt1, shcnt2, shcnt3, shcnt4, shcnt5, shcnt6;
reg shcnt_mod3, shcnt_mod4, shcnt_mod5;
reg [31:0] pcm2_mul;
wire signed [15:0] lin2s = {6'b0,lin2};
always @(*) begin
    shcnt_mod3 = shcnt3 != 0;
    shcnt_mod4 = shcnt4 != 0;
    shcnt_mod5 = shcnt5 != 0;
    pcm2_mul   = pcm2 * lin2s;
end
reg signed [15:0] pcm1, pcm2, pcm3, pcm4, pcm5, pcm6;
reg match2;
assign pcm_att = pcm1;
always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        pcm1   <= 'd0; pcm2   <= 'd0;
        pcm3   <= 'd0; pcm4   <= 'd0;
        pcm5   <= 'd0; pcm6   <= 'd0;
        shcnt1 <= 'd0; shcnt2 <= 'd0;
        shcnt3 <= 'd0; shcnt4 <= 'd0;
        shcnt5 <= 'd0; shcnt6 <= 'd0;
    end else if(cen) begin
        pcm2    <= match ? pcm_in : pcm1;
        lin2    <= lin1;
        shcnt2  <= match ? sh1 : shcnt1;
        match2  <= match;
        pcm3    <= match2 ? pcm2_mul[24:9] : pcm2;
        shcnt3  <= shcnt2;
        if( shcnt_mod3 ) begin
            pcm4   <= pcm3>>>1;
            shcnt4 <= shcnt3-1'd1;
        end else begin
            pcm4   <= pcm3;
            shcnt4 <= shcnt3;
        end
        if( shcnt_mod4 ) begin
            pcm5   <= pcm4>>>1;
            shcnt5 <= shcnt4-1'd1;
        end else begin
            pcm5   <= pcm4;
            shcnt5 <= shcnt4;
        end       
        if( shcnt_mod5 ) begin
            pcm6   <= pcm5>>>1;
            shcnt6 <= shcnt5-1'd1;
        end else begin
            pcm6   <= pcm5;
            shcnt6 <= shcnt5;
        end       
        pcm1    <= pcm6;
        shcnt1  <= shcnt6;
    end
endmodule