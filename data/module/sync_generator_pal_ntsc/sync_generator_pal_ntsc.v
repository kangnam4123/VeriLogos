module sync_generator_pal_ntsc (
    input wire clk,   
    input wire in_mode,  
    output reg csync_n,
    output wire [8:0] hc,
    output wire [8:0] vc,
    output reg blank
    );
    parameter PAL  = 1'b0;
    parameter NTSC = 1'b1;
    reg [8:0] h = 9'd0;
    reg [8:0] v = 9'd0;
    reg mode = PAL;
    assign hc = h;
    assign vc = v;
    always @(posedge clk) begin
        if (mode == PAL) begin
            if (h == 9'd447) begin
                h <= 9'd0;
                if (v == 9'd311) begin
                    v <= 9'd0;
                    mode <= in_mode;
                end
                else
                    v <= v + 9'd1;
            end
            else
                h <= h + 9'd1;
        end
        else begin 
            if (h == 9'd443) begin
                h <= 9'd0;
                if (v == 9'd261) begin
                    v <= 9'd0;
                    mode <= in_mode;
                end
                else
                    v <= v + 9'd1;
            end
            else
                h <= h + 9'd1;
        end
    end
    reg vblank, hblank, vsync_n, hsync_n;
    always @* begin
        vblank = 1'b0;
        hblank = 1'b0;
        vsync_n = 1'b1;
        hsync_n = 1'b1;
        if (mode == PAL) begin
            if (v >= 9'd304 && v <= 9'd311) begin
                vblank = 1'b1;
                if (v >= 9'd304 && v <= 9'd307) begin
                    vsync_n = 1'b0;
                end
            end
            if (h >= 9'd352 && h <= 9'd447) begin
                hblank = 1'b1;
                if (h >= 9'd376 && h <= 9'd407) begin
                    hsync_n = 1'b0;
                end
            end
        end
        else begin 
            if (v >= 9'd254 && v <= 9'd261) begin
                vblank = 1'b1;
                if (v >= 9'd254 && v <= 9'd257) begin
                    vsync_n = 1'b0;
                end
            end
            if (h >= 9'd352 && h <= 9'd443) begin
                hblank = 1'b1;
                if (h >= 9'd376 && h <= 9'd407) begin
                    hsync_n = 1'b0;
                end
            end
        end
        blank = hblank | vblank;
        csync_n = hsync_n & vsync_n;
    end
endmodule