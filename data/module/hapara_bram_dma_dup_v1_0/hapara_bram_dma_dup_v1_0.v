module hapara_bram_dma_dup_v1_0 #
	(
		parameter integer DATA_WIDTH	= 32
	)
	(
		input   [DATA_WIDTH - 1 : 0] addr_ctrl,
        input   [DATA_WIDTH - 1 : 0] data_in_ctrl,
        output  [DATA_WIDTH - 1 : 0] data_out_ctrl,
        input   [DATA_WIDTH / 8 - 1 : 0] we_ctrl,
        input   clk_ctrl,
        input   rst_ctrl,
        input   en_ctrl,
        output  [DATA_WIDTH - 1 : 0] addr_inst,
        output  [DATA_WIDTH - 1 : 0] data_in_inst,
        input   [DATA_WIDTH - 1 : 0] data_out_inst,
        output  [DATA_WIDTH / 8 - 1 : 0] we_inst,
        output  clk_inst,
        output  rst_inst,
        output  en_inst,
        output  [DATA_WIDTH - 1 : 0] addr_data,
        output  [DATA_WIDTH - 1 : 0] data_in_data,
        input   [DATA_WIDTH - 1 : 0] data_out_data,
        output  [DATA_WIDTH / 8 - 1 : 0] we_data,
        output  clk_data,
        output  rst_data,
        output  en_data
	);
    assign  clk_inst = clk_ctrl;
    assign  clk_data = clk_ctrl;
    assign  rst_inst = rst_ctrl;
    assign  rst_data = rst_ctrl;
    assign  we_inst = we_ctrl;
    assign  we_data = we_ctrl;
    assign  addr_inst = addr_ctrl;
    assign  addr_data = addr_ctrl;
    assign  data_in_inst = data_in_ctrl;
    assign  data_in_data = data_in_ctrl;
    assign  en_inst = en_ctrl;
    assign  en_data = en_ctrl;
    assign  data_out_ctrl = data_out_data;
	endmodule