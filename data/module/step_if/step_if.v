module step_if(clk, rst_, ena_, rdy_, mem_re_, abus, dbus, pc_din, pc_dout, pc_we_, inst);
    input clk;
    input rst_;
    input ena_;
    output rdy_;
    output mem_re_;
    output[7:0] abus;
    input[7:0] dbus;
    output[7:0] pc_din;
    input[7:0] pc_dout;
    output pc_we_;
    output[7:0] inst;
    reg rdy_;
    reg mem_re_en;
    assign mem_re_ = mem_re_en ? 1'b0 : 1'bZ;
    assign abus = mem_re_en ? pc_dout : 8'bZ;
    reg[7:0] pc_din;
    reg pc_we_en;
    assign pc_we_ = pc_we_en ? 1'b0 : 1'bZ;
    reg[7:0] inst;
    reg[3:0] state;
    always @(negedge clk or negedge rst_)
        if(!rst_) begin
            rdy_ <= 1;
            mem_re_en <= 0;
            pc_din <= 8'bZ;
            pc_we_en <= 0;
            inst <= 0;
            state <= 0;
        end else begin
            rdy_ <= ~state[3];
            mem_re_en <= ~ena_ | state[0];
            pc_din <= (state[1] | state[2]) ? (pc_dout+8'd1) : 8'bZ;
            pc_we_en <= state[2];
            inst <= state[0] ? dbus : inst;
            state <= {state[2:0], ~ena_};
        end
endmodule