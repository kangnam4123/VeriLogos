module fx2_to_bus #(
    parameter                   WIDTH = 16 
) (
    input wire [WIDTH-1:0]      ADD,
    input wire                  RD_B, 
    input wire                  WR_B, 
    input wire                  BUS_CLK, 
    output wire [WIDTH-1:0]     BUS_ADD,
    output wire                 BUS_RD,
    output wire                 BUS_WR,
    output wire                 CS_FPGA
);
assign BUS_ADD = ADD - 16'h4000;
assign CS_FPGA = ~ADD[15] & ADD[14];
reg RD_B_FF;
always @(posedge BUS_CLK) begin
    RD_B_FF <= RD_B;
end
assign BUS_RD = ~RD_B & RD_B_FF;
assign BUS_WR = ~WR_B;
endmodule