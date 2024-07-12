module gtxe2_chnl_cpll_inmux(
    input   wire    [2:0]   CPLLREFCLKSEL,
    input   wire            GTREFCLK0,
    input   wire            GTREFCLK1,
    input   wire            GTNORTHREFCLK0,
    input   wire            GTNORTHREFCLK1,
    input   wire            GTSOUTHREFCLK0,
    input   wire            GTSOUTHREFCLK1,
    input   wire            GTGREFCLK,
    output  wire            CPLL_MUX_CLK_OUT
);
assign CPLL_MUX_CLK_OUT = CPLLREFCLKSEL == 3'b000 ?     1'b0 
                        : CPLLREFCLKSEL == 3'b001 ?     GTREFCLK0
                        : CPLLREFCLKSEL == 3'b010 ?     GTREFCLK1
                        : CPLLREFCLKSEL == 3'b011 ?     GTNORTHREFCLK0
                        : CPLLREFCLKSEL == 3'b100 ?     GTNORTHREFCLK1
                        : CPLLREFCLKSEL == 3'b101 ?     GTSOUTHREFCLK0
                        : CPLLREFCLKSEL == 3'b110 ?     GTSOUTHREFCLK1
                        :  GTGREFCLK;
endmodule