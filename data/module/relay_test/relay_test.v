module relay_test(
    pck0, ck_1356meg, ck_1356megb,
    ssp_frame, ssp_din, ssp_dout, ssp_clk,
    data_in, data_out,
    mod_type
);
    input pck0, ck_1356meg, ck_1356megb;
    input ssp_dout;
    output ssp_frame, ssp_din, ssp_clk;
    input data_in;
    output data_out;
    input [2:0] mod_type;
reg ssp_clk = 1'b0;
reg ssp_frame = 1'b0;
reg data_out = 1'b0;
reg ssp_din = 1'b0;
reg [6:0] div_counter = 7'b0;
reg [0:0] buf_data_in = 1'b0;
reg [0:0] receive_counter = 1'b0;
reg [31:0] delay_counter = 32'h0;
reg [3:0] counter = 4'b0;
reg [7:0] receive_buffer = 8'b0;
reg sending_started = 1'b0;
reg received_complete = 1'b0;
reg [7:0] received = 8'b0;
reg [3:0] send_buf = 4'b0;
reg [16:0] to_arm_delay = 17'b0;
always @(posedge ck_1356meg)
begin
end
endmodule