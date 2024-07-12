module single_port_ram_sync
#(
  parameter ADDR_WIDTH = 6,
  parameter DATA_WIDTH = 8
)
(
  input  wire                  clk,
  input  wire                  we,
  input  wire [ADDR_WIDTH-1:0] addr_a,
  input  wire [DATA_WIDTH-1:0] din_a,
  output wire [DATA_WIDTH-1:0] dout_a
);
reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
reg [ADDR_WIDTH-1:0] q_addr_a;
always @(posedge clk)
  begin
    if (we)
        ram[addr_a] <= din_a;
    q_addr_a <= addr_a;
  end
assign dout_a = ram[q_addr_a];
endmodule