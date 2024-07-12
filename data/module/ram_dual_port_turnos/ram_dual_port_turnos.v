module ram_dual_port_turnos (
    input wire clk,
    input wire whichturn,
    input wire [18:0] vramaddr,
    input wire [18:0] cpuramaddr,
    input wire cpu_we_n,
    input wire [7:0] data_from_cpu,
    output reg [7:0] data_to_asic,
    output reg [7:0] data_to_cpu,
    output reg [18:0] sram_a,
    output reg sram_we_n,
    inout wire [7:0] sram_d
    );
    assign sram_d = (cpu_we_n == 1'b0 && whichturn == 1'b0)? data_from_cpu : 8'hZZ;    
    always @* begin
        data_to_cpu = 8'hFF;
        data_to_asic = 8'hFF;
        if (whichturn == 1'b1) begin 
            sram_a = vramaddr;
            sram_we_n = 1'b1;
            data_to_asic = sram_d;
        end
        else begin
            sram_a = cpuramaddr;
            sram_we_n = cpu_we_n;
            data_to_cpu = sram_d;
        end
    end
endmodule