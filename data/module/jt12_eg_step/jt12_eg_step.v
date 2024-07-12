module jt12_eg_step(
    input           attack,
    input [ 4:0]    base_rate,
    input [ 4:0]    keycode,
    input [14:0]    eg_cnt,
    input           cnt_in,
    input [ 1:0]    ks,
    output          cnt_lsb,
    output       reg step,
    output reg [5:0] rate,
    output reg      sum_up
);
reg     [6:0]   pre_rate;
always @(*) begin : pre_rate_calc
    if( base_rate == 5'd0 )
        pre_rate = 7'd0;
    else
        case( ks )
            2'd3:   pre_rate = { base_rate, 1'b0 } + { 1'b0, keycode };
            2'd2:   pre_rate = { base_rate, 1'b0 } + { 2'b0, keycode[4:1] };
            2'd1:   pre_rate = { base_rate, 1'b0 } + { 3'b0, keycode[4:2] };
            2'd0:   pre_rate = { base_rate, 1'b0 } + { 4'b0, keycode[4:3] };
        endcase
end
always @(*)
    rate = pre_rate[6] ? 6'd63 : pre_rate[5:0];
reg [2:0] cnt;
reg [4:0] mux_sel;
always @(*) begin
    mux_sel = attack ? (rate[5:2]+4'd1): {1'b0,rate[5:2]};
end 
always @(*) 
    case( mux_sel )
        5'h0: cnt = eg_cnt[14:12];
        5'h1: cnt = eg_cnt[13:11];
        5'h2: cnt = eg_cnt[12:10];
        5'h3: cnt = eg_cnt[11: 9];
        5'h4: cnt = eg_cnt[10: 8];
        5'h5: cnt = eg_cnt[ 9: 7];
        5'h6: cnt = eg_cnt[ 8: 6];
        5'h7: cnt = eg_cnt[ 7: 5];
        5'h8: cnt = eg_cnt[ 6: 4];
        5'h9: cnt = eg_cnt[ 5: 3];
        5'ha: cnt = eg_cnt[ 4: 2];
        5'hb: cnt = eg_cnt[ 3: 1];
        default: cnt = eg_cnt[ 2: 0];
    endcase
reg [7:0] step_idx;
always @(*) begin : rate_step
    if( rate[5:4]==2'b11 ) begin 
        if( rate[5:2]==4'hf && attack)
            step_idx = 8'b11111111; 
        else
        case( rate[1:0] )
            2'd0: step_idx = 8'b00000000;
            2'd1: step_idx = 8'b10001000; 
            2'd2: step_idx = 8'b10101010; 
            2'd3: step_idx = 8'b11101110; 
        endcase
    end
    else begin
        if( rate[5:2]==4'd0 && !attack)
            step_idx = 8'b11111110; 
        else
        case( rate[1:0] )
            2'd0: step_idx = 8'b10101010; 
            2'd1: step_idx = 8'b11101010; 
            2'd2: step_idx = 8'b11101110; 
            2'd3: step_idx = 8'b11111110; 
        endcase
    end
    step = rate[5:1]==5'd0 ? 1'b0 : step_idx[ cnt ];
end
assign cnt_lsb = cnt[0];
always @(*) begin
    sum_up = cnt[0] != cnt_in;
end
endmodule