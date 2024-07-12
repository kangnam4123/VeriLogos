module wishbone_bus #(
    parameter                              ADDR_WIDTH       = 32,
    parameter                              DATA_WIDTH       = 32,
    parameter                              SLAVE_0_BASE     = 'h0100,
    parameter                              SLAVE_1_BASE     = 'h0200,
    parameter                              SLAVE_2_BASE     = 'h0300,
    parameter                              SLAVE_3_BASE     = 'h0400,
    parameter                              SLAVE_RANGE      = 'h0040
) (
    input          [ADDR_WIDTH-1:0]     adr_master,
    input                               cyc_master,
    input          [DATA_WIDTH-1:0]     dat_ms_master,
    input                               stb_master,
    input                               we_master,
    output reg                          ack_master,
    output reg     [DATA_WIDTH-1:0]     dat_sm_master,
    output reg                          err_master,
    input                               ack_slave_0,
    input          [DATA_WIDTH-1:0]     dat_sm_slave_0,
    input                               err_slave_0,
    output         [ADDR_WIDTH-1:0]     adr_slave_0,
    output                              cyc_slave_0,
    output         [DATA_WIDTH-1:0]     dat_ms_slave_0,
    output                              stb_slave_0,
    output                              we_slave_0,
    input                               ack_slave_1,
    input          [DATA_WIDTH-1:0]     dat_sm_slave_1,
    input                               err_slave_1,
    output         [ADDR_WIDTH-1:0]     adr_slave_1,
    output                              cyc_slave_1,
    output         [DATA_WIDTH-1:0]     dat_ms_slave_1,
    output                              stb_slave_1,
    output                              we_slave_1,
    input                               ack_slave_2,
    input          [DATA_WIDTH-1:0]     dat_sm_slave_2,
    input                               err_slave_2,
    output         [ADDR_WIDTH-1:0]     adr_slave_2,
    output                              cyc_slave_2,
    output         [DATA_WIDTH-1:0]     dat_ms_slave_2,
    output                              stb_slave_2,
    output                              we_slave_2,
    input                               ack_slave_3,
    input          [DATA_WIDTH-1:0]     dat_sm_slave_3,
    input                               err_slave_3,
    output         [ADDR_WIDTH-1:0]     adr_slave_3,
    output                              cyc_slave_3,
    output         [DATA_WIDTH-1:0]     dat_ms_slave_3,
    output                              stb_slave_3,
    output                              we_slave_3
);
    assign adr_slave_0 = adr_master;
    assign cyc_slave_0 = cyc_master;
    assign dat_ms_slave_0 = dat_ms_master;
    assign we_slave_0 = we_master;
    assign adr_slave_1 = adr_master;
    assign cyc_slave_1 = cyc_master;
    assign dat_ms_slave_1 = dat_ms_master;
    assign we_slave_1 = we_master;
    assign adr_slave_2 = adr_master;
    assign cyc_slave_2 = cyc_master;
    assign dat_ms_slave_2 = dat_ms_master;
    assign we_slave_2 = we_master;
    assign adr_slave_3 = adr_master;
    assign cyc_slave_3 = cyc_master;
    assign dat_ms_slave_3 = dat_ms_master;
    assign we_slave_3 = we_master;
    wire slave_0_sel = (adr_master >= SLAVE_0_BASE && adr_master < SLAVE_0_BASE+SLAVE_RANGE) ? 1 : 0;
    wire slave_1_sel = (adr_master >= SLAVE_1_BASE && adr_master < SLAVE_1_BASE+SLAVE_RANGE) ? 1 : 0;
    wire slave_2_sel = (adr_master >= SLAVE_2_BASE && adr_master < SLAVE_2_BASE+SLAVE_RANGE) ? 1 : 0;
    wire slave_3_sel = (adr_master >= SLAVE_3_BASE && adr_master < SLAVE_3_BASE+SLAVE_RANGE) ? 1 : 0;
    always @* begin
        if (slave_0_sel) begin
            dat_sm_master <= dat_sm_slave_0;
            ack_master <= ack_slave_0;
            err_master <= err_slave_0;
        end
        else if (slave_1_sel) begin
            dat_sm_master <= dat_sm_slave_1;
            ack_master <= ack_slave_1;
            err_master <= err_slave_1;
        end
        else if (slave_2_sel) begin
            dat_sm_master <= dat_sm_slave_2;
            ack_master <= ack_slave_2;
            err_master <= err_slave_2;
        end
        else if (slave_3_sel) begin
            dat_sm_master <= dat_sm_slave_3;
            ack_master <= ack_slave_3;
            err_master <= err_slave_3;
        end
        else begin
            dat_sm_master <= 0;
            ack_master <= 0;
            err_master <= 0;
        end
    end
    assign stb_slave_0 = slave_0_sel ? stb_master : 0;
    assign stb_slave_1 = slave_1_sel ? stb_master : 0;
    assign stb_slave_2 = slave_2_sel ? stb_master : 0;
    assign stb_slave_3 = slave_3_sel ? stb_master : 0;
endmodule