module qm_icache(
    input wire [31:0] address,
    input wire reset,
    input wire clk,
    output reg hit,
    output reg stall,
    output reg [31:0] data,
    input wire enable,
    output wire mem_cmd_clk, 
    output reg mem_cmd_en,
    output reg [2:0] mem_cmd_instr,
    output reg [5:0] mem_cmd_bl,
    output reg [29:0] mem_cmd_addr,
    input wire mem_cmd_full,
    input wire mem_cmd_empty,
    output wire mem_rd_clk,
    output reg mem_rd_en,
    input wire [6:0] mem_rd_count,
    input wire mem_rd_full,
    input wire [31:0] mem_rd_data,
    input wire mem_rd_empty
);
reg [144:0] lines [4095:0];
reg valid_bit;
wire [11:0] index;
wire index_valid;
wire [15:0] index_tag;
wire [15:0] address_tag;
wire [1:0] address_word;
assign index = address[15:4];
assign index_valid = lines[index][144];
assign index_tag = lines[index][143:128];
assign address_tag = address[31:16];
assign address_word = address[3:2];
assign mem_rd_clk = clk;
assign mem_cmd_clk = clk;
generate
    genvar i;
    for (i = 0; i < 4096; i = i + 1) begin: ruchanie
        always @(posedge clk) begin
            if (reset) begin
                lines[0] <= {145'b0};
            end
        end
    end
endgenerate
always @(posedge clk) begin
    if (reset) begin
        valid_bit <= 1;
        memory_read_state <= 0;
        mem_cmd_en <= 0;
        mem_cmd_bl <= 0;
        mem_cmd_instr <= 0;
        mem_cmd_addr <= 0;
        mem_rd_en <= 0;
    end
end
always @(*) begin
    if (enable) begin
        if (32'h80000000 <= address && address < 32'h90000000) begin
            if (index_valid == valid_bit && index_tag == address_tag) begin
                if (address_word == 2'b00)
                    data = lines[index][31:0];
                else if (address_word == 2'b01)
                    data = lines[index][63:32];
                else if (address_word == 2'b10)
                    data = lines[index][95:64];
                else
                    data = lines[index][127:96];
                hit = 1;
                stall = 0;
            end else begin
                hit = 0;
                stall = 1;
            end
        end else begin
            hit = 1;
            stall = 0;
            data = 32'h00000000;
        end
    end else begin
        hit = 0;
        stall = 0;
    end
end
reg [2:0] memory_read_state;
always @(posedge clk) begin
    if (stall && !reset && enable) begin
        case (memory_read_state)
            0: begin 
                mem_cmd_instr <= 1; 
                mem_cmd_bl <= 3; 
                mem_cmd_addr <= {1'b0, address[28:0]};
                mem_cmd_en <= 0;
                memory_read_state <= 1;
            end
            1: begin 
                mem_cmd_en <= 1;
                memory_read_state <= 2;
                mem_rd_en <= 1;
            end
            2: begin 
                mem_cmd_en <= 0;
                if (!mem_rd_empty) begin
                    lines[index][31:0] <= mem_rd_data;
                    memory_read_state <= 3;
                end
            end
            3: begin 
                if (!mem_rd_empty) begin
                    lines[index][63:32] <= mem_rd_data;
                    memory_read_state <= 4;
                end
            end
            4: begin 
                if (!mem_rd_empty) begin
                    lines[index][95:64] <= mem_rd_data;
                    memory_read_state <= 5;
                end
            end
            5: begin 
                if (!mem_rd_empty) begin
                    lines[index][127:96] <= mem_rd_data;
                    memory_read_state <= 0;
                    mem_rd_en <= 0;
                    lines[index][143:128] <= address_tag;
                    lines[index][144] <= valid_bit;
                end
            end
        endcase
    end
end
endmodule