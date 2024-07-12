module video_scaler_sdivhbi_div_u
#(parameter
    in0_WIDTH = 32,
    in1_WIDTH = 32,
    out_WIDTH = 32
)
(
    input                       clk,
    input                       reset,
    input                       ce,
    input                       start,
    input       [in0_WIDTH-1:0] dividend,
    input       [in1_WIDTH-1:0] divisor,
    input       [1:0]           sign_i,
    output wire [1:0]           sign_o,
    output wire                 done,
    output wire [out_WIDTH-1:0] quot,
    output wire [out_WIDTH-1:0] remd
);
localparam cal_WIDTH = (in0_WIDTH > in1_WIDTH)? in0_WIDTH : in1_WIDTH;
reg     [in0_WIDTH-1:0] dividend0;
reg     [in1_WIDTH-1:0] divisor0;
reg     [1:0]           sign0;
reg     [in0_WIDTH-1:0] dividend_tmp;
reg     [in0_WIDTH-1:0] remd_tmp;
wire    [in0_WIDTH-1:0] dividend_tmp_mux;
wire    [in0_WIDTH-1:0] remd_tmp_mux;
wire    [in0_WIDTH-1:0] comb_tmp;
wire    [cal_WIDTH:0]   cal_tmp;
assign  quot   = dividend_tmp;
assign  remd   = remd_tmp;
assign  sign_o = sign0;
always @(posedge clk)
begin
    if (start) begin
        dividend0 <= dividend;
        divisor0  <= divisor;
        sign0     <= sign_i;
    end
end
reg     [in0_WIDTH:0]     r_stage;
assign done = r_stage[in0_WIDTH];
always @(posedge clk)
begin
    if (reset == 1'b1)
        r_stage[in0_WIDTH:0] <= {in0_WIDTH{1'b0}};
    else if (ce)
        r_stage[in0_WIDTH:0] <= {r_stage[in0_WIDTH-1:0], start};
end
assign  dividend_tmp_mux = r_stage[0]? dividend0 : dividend_tmp;
assign  remd_tmp_mux     = r_stage[0]? {in0_WIDTH{1'b0}} : remd_tmp;
if (in0_WIDTH == 1) assign comb_tmp = dividend_tmp_mux[0];
else                assign comb_tmp = {remd_tmp_mux[in0_WIDTH-2:0], dividend_tmp_mux[in0_WIDTH-1]};
assign  cal_tmp  = {1'b0, comb_tmp} - {1'b0, divisor0};
always @(posedge clk)
begin
    if (ce) begin
        if (in0_WIDTH == 1) dividend_tmp <= ~cal_tmp[cal_WIDTH];
        else           dividend_tmp <= {dividend_tmp_mux[in0_WIDTH-2:0], ~cal_tmp[cal_WIDTH]};
        remd_tmp     <= cal_tmp[cal_WIDTH]? comb_tmp : cal_tmp[in0_WIDTH-1:0];
    end
end
endmodule