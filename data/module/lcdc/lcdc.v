module lcdc(
    input wire clk, 
    input wire rst,
    output wire [8:0] x_o,
    output wire [6:0] y_o,
    output wire in_vsync_o,
    output wire in_hsync_o,
    output wire pop_o,
    input wire [5:0] r_i,
    input wire [5:0] g_i,
    input wire [5:0] b_i,
    input wire ack_i,
    output wire [5:0] lcd_r,
    output wire [5:0] lcd_g,
    output wire [5:0] lcd_b,
    output wire lcd_vsync,
    output wire lcd_hsync,
    output wire lcd_nclk,
    output wire lcd_de);
reg [3:0] counter_ff;
always @(posedge clk) begin
    if (rst) begin
        counter_ff <= 4'h0;
    end else begin
        counter_ff <= counter_ff + 1;
    end
end
reg send_req_ff;
reg update_x_ff;
reg update_y_ff;
reg update_data_ff;
always @(posedge clk) begin
    if (rst) begin
        send_req_ff <= 1'b0;
        update_x_ff <= 1'b0;
        update_y_ff <= 1'b0;
        update_data_ff <= 1'b0;
    end else begin
        if (counter_ff == 4'hf)
            send_req_ff <= 1'b1;
        else
            send_req_ff <= 1'b0;
        if (counter_ff == 4'hc)
            update_x_ff <= 1'b1;
        else
            update_x_ff <= 1'b0;
        if (counter_ff == 4'hd)
            update_y_ff <= 1'b1;
        else
            update_y_ff <= 1'b0;
        if (counter_ff == 4'he)
            update_data_ff <= 1'b1;
        else
            update_data_ff <= 1'b0;
    end
end
wire send_req = send_req_ff;
wire update_x = update_x_ff;
wire update_y = update_y_ff;
wire update_data = update_data_ff;
reg lcd_nclk_ff;
always @(posedge clk) begin
    if (rst)
        lcd_nclk_ff <= 1'b0;
    else begin
        if (counter_ff < 4'h8)
            lcd_nclk_ff <= 1'b1;
        else
            lcd_nclk_ff <= 1'b0;
    end
end
reg [8:0] curr_x_ff;
reg in_hsync_ff;
always @(posedge clk) begin
    if (rst) begin
        curr_x_ff <= 9'd400;
        in_hsync_ff <= 1'b0;
    end else begin
        if (update_x) begin
            if (curr_x_ff == 9'd506) begin
                curr_x_ff <= 9'd000;
                in_hsync_ff <= 0;
            end else begin
                curr_x_ff <= curr_x_ff + 1;
                in_hsync_ff <= (curr_x_ff >= 9'd400) ? 1'b1 : 1'b0;
            end
        end
    end
end
reg lcd_hsync_ff;
always @(posedge clk) begin
    if (rst)
        lcd_hsync_ff <= 1'b1;
    else begin
        if (update_data) begin
            if (curr_x_ff == 9'd401)
                lcd_hsync_ff <= 1'b0;
            else
                lcd_hsync_ff <= 1'b1;
        end
    end
end
reg [6:0] curr_y_ff;
reg in_vsync_ff;
always @(posedge clk) begin
    if (rst) begin
        curr_y_ff <= 7'd96;
        in_vsync_ff <= 1'b0;
    end else begin
        if (update_y && curr_x_ff == 9'd400) begin
            if (curr_y_ff == 7'd111) begin
                curr_y_ff <= 7'd0;
                in_vsync_ff <= 1'b0;
            end else begin
                curr_y_ff <= curr_y_ff + 1;
                in_vsync_ff <= (curr_y_ff >= 7'd96) ? 1'b1 : 1'b0;
            end
        end
    end
end
reg lcd_vsync_ff;
always @(posedge clk) begin
    if (rst)
        lcd_vsync_ff <= 1'b1;
    else begin
        if (update_data) begin
            if (curr_y_ff == 7'd97)
                lcd_vsync_ff <= 1'b0;
            else
                lcd_vsync_ff <= 1'b1;
        end
    end
end
assign x_o = curr_x_ff;
assign y_o = curr_y_ff;
assign in_hsync_o = in_hsync_ff;
assign in_vsync_o = in_vsync_ff;
assign pop_o = send_req;
reg [5:0] lcd_r_pending_ff;
reg [5:0] lcd_g_pending_ff;
reg [5:0] lcd_b_pending_ff;
always @(posedge clk) begin
    if (rst) begin
        lcd_r_pending_ff <= 6'h00;
        lcd_g_pending_ff <= 6'h00;
        lcd_b_pending_ff <= 6'h00;
    end else if (ack_i) begin
        lcd_r_pending_ff <= r_i;
        lcd_g_pending_ff <= g_i;
        lcd_b_pending_ff <= b_i;
    end
end
reg [5:0] lcd_r_ff;
reg [5:0] lcd_g_ff;
reg [5:0] lcd_b_ff;
always @(posedge clk) begin
    if (rst) begin
        lcd_r_ff <= 6'h00;
        lcd_g_ff <= 6'h00;
        lcd_b_ff <= 6'h00;
    end else if (update_data) begin
        lcd_r_ff <= lcd_r_pending_ff;
        lcd_g_ff <= lcd_g_pending_ff;
        lcd_b_ff <= lcd_b_pending_ff;
    end
end
assign lcd_de = 1'b0;
assign lcd_vsync = lcd_vsync_ff;
assign lcd_hsync = lcd_hsync_ff;
assign lcd_nclk = lcd_nclk_ff;
assign lcd_r[5:0] = lcd_r_ff;
assign lcd_g[5:0] = lcd_g_ff;
assign lcd_b[5:0] = lcd_b_ff;
endmodule