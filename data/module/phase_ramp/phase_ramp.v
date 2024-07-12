module phase_ramp #
(
    parameter integer PHASE_WIDTH = 16,
    parameter integer FRACTIONAL_WIDTH = 13
)
(
    input  wire                        adc_clk,
    input  wire                        aclk,
    input  wire                        aresetn,
    input  wire [FRACTIONAL_WIDTH-1:0] phase_increment,
    output wire [PHASE_WIDTH-1:0]      phase_tdata,
    input  wire                        phase_tready,
    output wire                        phase_tvalid
);
reg [FRACTIONAL_WIDTH:0] phase_counter;
reg [FRACTIONAL_WIDTH:0] phase_counter_next;
reg r1, r2, r3;
reg reset;
always @(posedge aclk) begin
    if (~aresetn) begin
        reset <= 1'b1;
        r1 <= 1;
        r2 <= 1;
        r3 <= 1;
    end else begin
        r1 <= adc_clk;
        r2 <= r1;
        r3 <= r2;
    end
end
always @(posedge adc_clk) begin
    if (reset) begin
        phase_counter <= {(FRACTIONAL_WIDTH){1'b0}};
        phase_counter_next <= phase_increment;
        reset <= 1'b0;
    end else begin
        phase_counter <= phase_counter_next;
        phase_counter_next <= phase_counter_next  + phase_increment;
    end
end
assign phase_tvalid = r2 && !r3;
assign phase_tdata = {{(PHASE_WIDTH - FRACTIONAL_WIDTH - 1){phase_counter[FRACTIONAL_WIDTH]}}, phase_counter};
endmodule