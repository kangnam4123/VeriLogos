module i2s_ctrl #
(
    parameter WIDTH = 16
)
(
    input  wire              clk,
    input  wire              rst,
    output wire              sck,
    output wire              ws,
    input  wire [15:0]       prescale
);
reg [15:0] prescale_cnt = 0;
reg [$clog2(WIDTH)-1:0] ws_cnt = 0;
reg sck_reg = 0;
reg ws_reg = 0;
assign sck = sck_reg;
assign ws = ws_reg;
always @(posedge clk) begin
    if (rst) begin
        prescale_cnt <= 0;
        ws_cnt <= 0;
        sck_reg <= 0;
        ws_reg <= 0;
    end else begin
        if (prescale_cnt > 0) begin
            prescale_cnt <= prescale_cnt - 1;
        end else begin
            prescale_cnt <= prescale;
            if (sck_reg) begin
                sck_reg <= 0;
                if (ws_cnt > 0) begin
                    ws_cnt <= ws_cnt - 1;
                end else begin
                    ws_cnt <= WIDTH-1;
                    ws_reg <= ~ws_reg;
                end
            end else begin
                sck_reg <= 1;
            end
        end
    end
end
endmodule