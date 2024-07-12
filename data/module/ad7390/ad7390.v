module ad7390 #
(
    parameter integer CLK_DIV = 250,
    parameter integer DAC_WIDTH = 12,
    parameter integer AXI_WIDTH = 16
)
(  
    input  wire                 aclk,
    input  wire                 aresetn,
    output reg                  s_axis_tready,
    input  wire [AXI_WIDTH-1:0] s_axis_tdata,
    input  wire                 s_axis_tvalid,
    output reg                  dac_clk,
    output reg                  dac_sdi,
    output reg                  dac_ld,
    output reg                  dac_clr
);
reg [15:0] int_clk_div;
reg int_clk;
reg [DAC_WIDTH-1:0] data_reg;
reg data_rx;
reg [3:0] data_rx_bit;
always @(posedge aclk) begin
    if (~aresetn) begin
        int_clk <= 1'b0;
        int_clk_div <= 16'b0;
        s_axis_tready <= 1'b0;
        dac_clk <= 1'b0;
        dac_sdi <= 1'b0;
        dac_clr <= 1'b1;
        dac_ld  <= 1'b1;
        data_rx <= 1'b0;
    end else begin
        if (~data_rx) begin
            if (~s_axis_tready) begin
                s_axis_tready <= 1'b1;
            end else if (s_axis_tvalid) begin
                s_axis_tready <= 1'b0;
                data_reg <= s_axis_tdata[AXI_WIDTH-2:AXI_WIDTH-DAC_WIDTH-1];
                dac_sdi <= s_axis_tdata[AXI_WIDTH-1];
                data_rx <= 1'b1;
                data_rx_bit <= DAC_WIDTH - 1;
                dac_ld <= 1'b1;
                int_clk_div <= 1'b0;
                int_clk <= 1'b0;
            end
        end
        if (int_clk_div == CLK_DIV && dac_clk == 1) begin
            if (data_rx) begin
                if (data_rx_bit > 0) begin
                    data_rx_bit <= data_rx_bit - 1;
                    {dac_sdi, data_reg} <= {data_reg, 1'b0};
                end else begin
                    dac_ld <= 1'b0;
                    dac_sdi <= 1'b0;
                end
            end
        end
        if (int_clk_div == CLK_DIV) begin
            int_clk_div <= 0;
            int_clk <= ~int_clk;
            if (data_rx && dac_ld) begin
                dac_clk <= int_clk;
            end else if (~dac_ld) begin
                dac_ld <= 1'b1;
                data_rx <= 1'b0;
            end
        end else begin
            int_clk_div <= int_clk_div + 1;
        end
    end
end
endmodule