module lsu_streaming_prefetch_avalon_bust_master #(
        parameter AWIDTH           = 32,
        parameter MWIDTH           = 256,
        parameter MWIDTH_BYTES     = 32,
        parameter BURSTCOUNT_WIDTH = 6,
        parameter FIFO_DEPTH_LOG2   = 5
    ) (
        input clk,
        input reset,
        input flush,
        output active,
        output                            ready,
        input            [AWIDTH - 1 : 0] fifo_read_addr,
        input                             fifo_read,
        input  [BURSTCOUNT_WIDTH - 1 : 0] fifo_burst_size,
        output                            fifo_data_valid,
        output            [MWIDTH -1 : 0] fifo_data,
        output           [AWIDTH - 1 : 0] master_address,
        output                            master_read,
        output     [MWIDTH_BYTES - 1 : 0] master_byteenable,
        input            [MWIDTH - 1 : 0] master_readdata,
        input                             master_readdatavalid,
        output [BURSTCOUNT_WIDTH - 1 : 0] master_burstcount,
        input                             master_waitrequest
    );
    reg  [FIFO_DEPTH_LOG2 : 0] pending_reads;
    reg  [FIFO_DEPTH_LOG2 : 0] pending_discards; 
    wire                      keep_read;
    wire                      avm_read_accepted;
    wire                      finished_discard;
    wire                      can_discard_full_burst;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pending_reads <= 0;
            pending_discards <= 0;
        end else begin
            if (flush) begin
                pending_reads <= 0;
                pending_discards <= pending_discards + pending_reads - master_readdatavalid;
            end else begin
                pending_reads <= pending_reads + (avm_read_accepted ? master_burstcount : 0) - keep_read;
                pending_discards <= pending_discards - (~finished_discard & master_readdatavalid);
            end
        end
    end
    assign finished_discard = (pending_discards == 0);
    assign can_discard_full_burst = ~pending_discards[FIFO_DEPTH_LOG2];
    assign keep_read = finished_discard & master_readdatavalid;
    assign avm_read_accepted = master_read & !master_waitrequest;
    assign ready = !master_waitrequest & can_discard_full_burst;
    assign master_address = fifo_read_addr;
    assign master_read = fifo_read & can_discard_full_burst & !flush;
    assign master_byteenable = {MWIDTH_BYTES{1'b1}};
    assign master_burstcount = fifo_burst_size;
    assign fifo_data = master_readdata;
    assign fifo_data_valid = keep_read;
    assign active = |pending_reads | ~finished_discard;
endmodule