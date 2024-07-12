module jt10_adpcmb_cnt(
    input               rst_n,
    input               clk,    
    input               cen,    
    input   [15:0]      delta_n,
    input               clr,
    input               on,
    input               acmd_up_b,
    input       [15:0]  astart,
    input       [15:0]  aend,
    input               arepeat,
    output  reg [23:0]  addr,
    output  reg         nibble_sel,
    output  reg         chon,
    output  reg         flag,
    input               clr_flag,
    output  reg         restart,
    output  reg         adv
);
reg [15:0] cnt;
always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        cnt <= 'd0;
        adv <= 'b0;
    end else if(cen) begin
        if( clr) begin
            cnt <= 'd0;
            adv <= 'b0;
        end else begin
            if( on ) 
                {adv, cnt} <= {1'b0, cnt} + {1'b0, delta_n };
            else begin
                cnt <= 'd0;
                adv <= 1'b1; 
            end
        end
    end
reg set_flag, last_set;
always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        flag     <= 1'b0;
        last_set <= 'b0;
    end else begin
        last_set <= set_flag;
        if( clr_flag ) flag <= 1'b0;
        if( !last_set && set_flag ) flag <= 1'b1;
    end
always @(posedge clk or negedge rst_n)
    if(!rst_n) begin
        addr       <= 'd0;
        nibble_sel <= 'b0;
        set_flag   <= 'd0;
        chon       <= 'b0;
        restart    <= 'b0;
    end else if( !on || clr ) begin
        restart <= 'd0;
        chon <= 'd0;
    end else if( acmd_up_b && on ) begin
        restart <= 'd1;
    end else if( cen ) begin
        if( restart && adv ) begin
            addr <= {astart,8'd0};
            nibble_sel <= 'b0;
            restart <= 'd0;
            chon <= 'd1;
        end else if( chon && adv ) begin
            if( { addr, nibble_sel } != { aend, 8'hFF, 1'b1 } ) begin
                { addr, nibble_sel } <= { addr, nibble_sel } + 25'd1;
                set_flag <= 'd0;
            end else if(arepeat) begin
                restart <= 'd1;
            end else begin
                set_flag <= 'd1;
                chon <= 'd0;
            end
        end
    end 
endmodule