module ram_dual_port (
    input wire clk,
    input wire whichturn,
    input wire [18:0] vramaddr,
    input wire [18:0] cpuramaddr,
    input wire mreq_n,
    input wire rd_n,
    input wire wr_n,
    input wire rfsh_n,
    input wire [7:0] data_from_cpu,
    output wire [7:0] data_to_asic,
    output reg [7:0] data_to_cpu,
    output reg [18:0] sram_a,
    output reg sram_we_n,
    inout wire [7:0] sram_d
    );
    parameter ASIC = 3'd0,
              CPU1 = 3'd1,
              CPU2 = 3'd2,
              CPU3 = 3'd3,
              CPU4 = 3'd4,
              CPU5 = 3'd5,
              CPU6 = 3'd6,
              CPU7 = 3'd7;
    reg [2:0] state = ASIC;
    assign sram_d = (state == CPU5 || state == CPU6)? data_from_cpu : 8'hZZ;
    assign data_to_asic = sram_d;
    always @* begin
        if (whichturn == 1'b1) begin
            sram_a = vramaddr;
            sram_we_n = 1'b1;            
        end
        else begin
            sram_a = cpuramaddr;            
            data_to_cpu = sram_d;
            if (state == CPU6 || state == CPU5)
                sram_we_n = 1'b0;
            else
                sram_we_n = 1'b1;
        end
    end
    always @(posedge clk) begin
        case (state)
            ASIC:
                begin
                    if (whichturn == 1'b0)
                        state <= CPU1;
                end
            CPU1:
                begin
                    if (whichturn == 1'b1)
                        state <= ASIC;
                    else if (mreq_n == 1'b0 && rd_n == 1'b0)
                        state <= CPU2;
                    else if (mreq_n == 1'b0 && rd_n == 1'b1 && rfsh_n == 1'b1)
                        state <= CPU5;
                end
            CPU2:
                begin
                    if (whichturn == 1'b1)
                        state <= ASIC;
                    else
                        state <= CPU3;
                end
            CPU3:
                begin                    
                    if (whichturn == 1'b1)
                        state <= ASIC;
                    else
                        state <= CPU1;
                end
            CPU5:
                begin
                    if (whichturn == 1'b1)
                        state <= ASIC;
                    else if (mreq_n == 1'b1)
                        state <= CPU1;
                    else if (wr_n == 1'b0)
                        state <= CPU6;
                end
            CPU6:
                begin
                    state <= CPU7;
                end
            CPU7:
                begin
                    if (whichturn == 1'b1)
                        state <= ASIC;
                    else if (mreq_n == 1'b1)
                        state <= CPU1;
                end
            default: 
                begin
                    if (whichturn == 1'b1)
                        state <= ASIC;
                     else
                        state <= CPU1;
                end
        endcase
    end
endmodule