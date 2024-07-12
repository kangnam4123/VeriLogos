module single_port_ram #(
    parameter ADDR_WIDTH = 1,
    parameter DATA_WIDTH = 1
) (
    input [ADDR_WIDTH-1:0] addr,
    input [DATA_WIDTH-1:0] data,
    input we,
    input clock,
    output reg [DATA_WIDTH-1:0] out
);
    localparam MEM_DEPTH = 2 ** ADDR_WIDTH;
    reg [DATA_WIDTH-1:0] Mem[MEM_DEPTH-1:0];
    always@(posedge clock) begin
        if(we) begin
            Mem[addr] = data;
        end
    	out = Mem[addr]; 
    end
endmodule