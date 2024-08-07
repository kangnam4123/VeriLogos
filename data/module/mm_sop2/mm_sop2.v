module mm_sop2 (
    clock,
    reset,
    x,
    y
);
input clock;
input reset;
input signed [15:0] x;
output signed [15:0] y;
reg signed [15:0] y;
wire signed [34:0] wwire;
wire signed [30:0] cgens_g_11_y;
wire signed [33:0] cgens_g_11_x;
wire signed [30:0] cgens_g_10_y;
wire signed [32:0] cgens_g_10_x;
wire signed [30:0] cgens_g_9_y;
wire signed [31:0] cgens_g_9_x;
wire signed [30:0] cgens_g_8_x;
reg signed [15:0] cgens_g_7_x;
reg signed [15:0] cgens_g_6_x;
reg signed [15:0] cgens_g_5_x;
reg signed [15:0] cgens_g_4_x;
always @(posedge clock, negedge reset) begin: MM_SOP2_CGENS_G_0_RTL_DFF
    if (reset == 0) begin
        cgens_g_4_x <= 0;
    end
    else begin
        cgens_g_4_x <= x;
    end
end
always @(posedge clock, negedge reset) begin: MM_SOP2_CGENS_G_1_RTL_DFF
    if (reset == 0) begin
        cgens_g_5_x <= 0;
    end
    else begin
        cgens_g_5_x <= cgens_g_4_x;
    end
end
always @(posedge clock, negedge reset) begin: MM_SOP2_CGENS_G_2_RTL_DFF
    if (reset == 0) begin
        cgens_g_6_x <= 0;
    end
    else begin
        cgens_g_6_x <= cgens_g_5_x;
    end
end
always @(posedge clock, negedge reset) begin: MM_SOP2_CGENS_G_3_RTL_DFF
    if (reset == 0) begin
        cgens_g_7_x <= 0;
    end
    else begin
        cgens_g_7_x <= cgens_g_6_x;
    end
end
assign cgens_g_8_x = (cgens_g_4_x * 64);
assign cgens_g_9_y = (cgens_g_5_x * 64);
assign cgens_g_10_y = (cgens_g_6_x * 64);
assign cgens_g_11_y = (cgens_g_7_x * 64);
assign cgens_g_9_x = (cgens_g_8_x + 0);
assign cgens_g_10_x = (cgens_g_9_x + cgens_g_9_y);
assign cgens_g_11_x = (cgens_g_10_x + cgens_g_10_y);
assign wwire = (cgens_g_11_x + cgens_g_11_y);
always @(posedge clock, negedge reset) begin: MM_SOP2_RTL_SCALE
    if (reset == 0) begin
        y <= 0;
    end
    else begin
        y <= $signed(wwire >>> 8);
    end
end
endmodule