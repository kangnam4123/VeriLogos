module oddr #
(
    parameter TARGET = "GENERIC",
    parameter IODDR_STYLE = "IODDR2",
    parameter WIDTH = 1
)
(
    input  wire             clk,
    input  wire [WIDTH-1:0] d1,
    input  wire [WIDTH-1:0] d2,
    output wire [WIDTH-1:0] q
);
genvar n;
generate
if (TARGET == "XILINX") begin
    for (n = 0; n < WIDTH; n = n + 1) begin : oddr
        if (IODDR_STYLE == "IODDR") begin
            ODDR #(
                .DDR_CLK_EDGE("SAME_EDGE"),
                .SRTYPE("ASYNC")
            )
            oddr_inst (
                .Q(q[n]),
                .C(clk),
                .CE(1'b1),
                .D1(d1[n]),
                .D2(d2[n]),
                .R(1'b0),
                .S(1'b0)
            );
        end else if (IODDR_STYLE == "IODDR2") begin
            ODDR2 #(
                .DDR_ALIGNMENT("C0"),
                .SRTYPE("ASYNC")
            )
            oddr_inst (
                .Q(q[n]),
                .C0(clk),
                .C1(~clk),
                .CE(1'b1),
                .D0(d1[n]),
                .D1(d2[n]),
                .R(1'b0),
                .S(1'b0)
            );
        end
    end
end else if (TARGET == "ALTERA") begin
    altddio_out #(
        .WIDTH(WIDTH),
        .POWER_UP_HIGH("OFF"),
        .OE_REG("UNUSED")
    )
    altddio_out_inst (
        .aset(1'b0),
        .datain_h(d1),
        .datain_l(d2),
        .outclocken(1'b1),
        .outclock(clk),
        .aclr(1'b0),
        .dataout(q)
    );
end else begin
    reg [WIDTH-1:0] d_reg_1 = {WIDTH{1'b0}};
    reg [WIDTH-1:0] d_reg_2 = {WIDTH{1'b0}};
    reg [WIDTH-1:0] q_reg = {WIDTH{1'b0}};
    always @(posedge clk) begin
        d_reg_1 <= d1;
        d_reg_2 <= d2;
    end
    always @(posedge clk) begin
        q_reg <= d1;
    end
    always @(negedge clk) begin
        q_reg <= d_reg_2;
    end
    assign q = q_reg;
end
endgenerate
endmodule