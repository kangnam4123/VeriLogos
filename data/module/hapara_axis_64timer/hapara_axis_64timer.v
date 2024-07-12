module hapara_axis_64timer # (
    parameter DATA_WIDTH = 32
)(
    bram_clk,
    bram_rst,
    bram_en,
    bram_we,
    bram_addr,
    bram_din,
    bram_dout,
    valid,
    ready,
    data,
    rstn,
    clk
    );
    output bram_clk;
    output bram_rst;
    output bram_en;
    output [3 : 0] bram_we;
    output [DATA_WIDTH - 1 : 0] bram_addr;
    output [DATA_WIDTH - 1 : 0] bram_din;
    input  [DATA_WIDTH - 1 : 0] bram_dout;
    output valid;
    input ready;
    output [DATA_WIDTH - 1 : 0] data;
    input rstn;
    input clk;
    assign bram_clk = clk;
    assign bram_rst = ~rstn;
    reg [DATA_WIDTH - 1 : 0] bram_din;
    reg [2 * DATA_WIDTH - 1 : 0] counter;
    reg [2 * DATA_WIDTH - 1 : 0] temp;
    reg [DATA_WIDTH - 1 : 0] raddr;
    reg [1 : 0] curr_state;
    reg [1 : 0] next_state;
    localparam idle  = 2'b00;
    localparam s0    = 2'b01;
    localparam s1    = 2'b10;
    localparam wait0 = 2'b11;
    always @(posedge clk) begin
        if (~rstn) begin
            raddr <= {DATA_WIDTH{1'b0}};
        end else if (curr_state == s0 || curr_state == s1) begin
            raddr <= raddr + 4;
        end else begin
            raddr <= raddr;
        end
    end
    assign bram_addr = raddr;
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            curr_state <= idle;
        end else begin
            curr_state <= next_state;
        end
    end
    always @(*) begin
        case (curr_state)
            idle:
                if (ready) next_state = s0;
                else next_state = idle;
            s0:
                next_state = s1;
            s1:
                next_state = wait0;
            wait0:
                if (~ready) next_state = idle;
                else next_state = wait0;
            default:
                next_state = 2'bxx;
        endcase
    end
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            counter <= {2 * DATA_WIDTH{1'b0}};
        end else begin
            counter <= counter + 1;
        end
    end
    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            temp <= {2 * DATA_WIDTH{1'b0}};
        end else if ((curr_state == idle) && ready) begin
            temp <= counter;
        end else begin
            temp <= temp;
        end
    end
    always @(*) begin
        case (curr_state)
            idle:
                bram_din = {DATA_WIDTH{1'b0}};
            s0:
                bram_din = temp[DATA_WIDTH - 1 : 0];
            s1:   
                bram_din = temp[2 * DATA_WIDTH - 1 : DATA_WIDTH];
            wait0:
                bram_din = {DATA_WIDTH{1'b0}};
            default:
                bram_din = {DATA_WIDTH{1'bx}};
        endcase
    end
    assign bram_en = (curr_state == s0 || curr_state == s1)?1'b1:1'b0;
    assign bram_we = (curr_state == s0 || curr_state == s1)?4'b1111:4'b0000;
    assign valid = (curr_state == wait0 && ready)?1'b1:1'b0;
    assign data = (curr_state == wait0 && ready)?1:0;
endmodule