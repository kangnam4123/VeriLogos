module jt10_adpcm_acc(
    input           rst_n,
    input           clk,        
    input           cen,        
    input   [5:0]   cur_ch,
    input   [5:0]   en_ch,
    input           match,
    input           en_sum,
    input  signed [15:0] pcm_in,    
    output reg signed [15:0] pcm_out    
);
wire signed [17:0] pcm_in_long = en_sum ? { {2{pcm_in[15]}}, pcm_in } : 18'd0;
reg  signed [17:0] acc, last, pcm_full;
reg  signed [17:0] step;
reg signed [17:0] diff;
reg signed [22:0] diff_ext, step_full; 
always @(*) begin
    diff = acc-last;
    diff_ext = { {5{diff[17]}}, diff };
    step_full = diff_ext        
        + ( diff_ext << 1 )     
        + ( diff_ext << 3 )     
        + ( diff_ext << 5 );    
end
wire adv = en_ch[0] & cur_ch[0];
always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        step <= 'd0;
        acc  <= 18'd0;
        last <= 18'd0;
    end else if(cen) begin
        if( match )
            acc <= cur_ch[0] ? pcm_in_long : ( pcm_in_long + acc );
        if( adv ) begin
            step <= { {2{step_full[22]}}, step_full[22:7] }; 
            last <= acc;
        end
    end
wire overflow = |pcm_full[17:15] & ~&pcm_full[17:15];
always @(posedge clk or negedge rst_n)
    if( !rst_n ) begin
        pcm_full <= 18'd0;
    end else if(cen && cur_ch[0]) begin
        case( en_ch )
            6'b000_001: pcm_full <= last;
            6'b000_100,
            6'b010_000: pcm_full <= pcm_full + step;
            default:;
        endcase
        if( overflow )
            pcm_out <= pcm_full[17] ? 16'h8000 : 16'h7fff; 
        else
            pcm_out <= pcm_full[15:0];
    end
endmodule