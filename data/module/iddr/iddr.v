module iddr #
(
    parameter TARGET = "GENERIC",
    parameter IODDR_STYLE = "IODDR2",
    parameter WIDTH = 1
)
(
    input  wire             clk,
    input  wire [WIDTH-1:0] d,
    output wire [WIDTH-1:0] q1,
    output wire [WIDTH-1:0] q2
);
genvar n;
generate
if (TARGET == "XILINX") begin
    for (n = 0; n < WIDTH; n = n + 1) begin : iddr
        if (IODDR_STYLE == "IODDR") begin
            IDDR #(
                .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
                .SRTYPE("ASYNC")
            )
            iddr_inst (
                .Q1(q1[n]),
                .Q2(q2[n]),
                .C(clk),
                .CE(1'b1),
                .D(d[n]),
                .R(1'b0),
                .S(1'b0)
            );
        end else if (IODDR_STYLE == "IODDR2") begin
            IDDR2 #(
                .DDR_ALIGNMENT("C0")
            )
            iddr_inst (
                .Q0(q1[n]),
                .Q1(q2[n]),
                .C0(clk),
                .C1(~clk),
                .CE(1'b1),
                .D(d[n]),
                .R(1'b0),
                .S(1'b0)
            );
        end
    end
end else if (TARGET == "ALTERA") begin
    wire [WIDTH-1:0] q1_int;
    reg [WIDTH-1:0] q1_delay;
    altddio_in #(
        .WIDTH(WIDTH),
        .POWER_UP_HIGH("OFF")
    )
    altddio_in_inst (
        .aset(1'b0),
        .datain(d),
        .inclocken(1'b1),
        .inclock(clk),
        .aclr(1'b0),
        .dataout_h(q1_int),
        .dataout_l(q2)
    );
    always @(posedge clk) begin
        q1_delay <= q1_int;
    end
    assign q1 = q1_delay;
end else begin
    reg [WIDTH-1:0] d_reg_1 = {WIDTH{1'b0}};
    reg [WIDTH-1:0] d_reg_2 = {WIDTH{1'b0}};
    reg [WIDTH-1:0] q_reg_1 = {WIDTH{1'b0}};
    reg [WIDTH-1:0] q_reg_2 = {WIDTH{1'b0}};
    always @(posedge clk) begin
        d_reg_1 <= d;
    end
    always @(negedge clk) begin
        d_reg_2 <= d;
    end
    always @(posedge clk) begin
        q_reg_1 <= d_reg_1;
        q_reg_2 <= d_reg_2;
    end
    assign q1 = q_reg_1;
    assign q2 = q_reg_2;
end
endgenerate
endmodule