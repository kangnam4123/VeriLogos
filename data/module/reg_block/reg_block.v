module reg_block(
  input [2:0] raddr1,
  input [2:0] raddr2,
  input [2:0] waddr,
  input [15:0] wdata,
  input clk_n,
  input wea,
  output [15:0] rdata1,
  output [15:0] rdata2
);
reg [15:0] registers [7:0];
assign rdata1 = registers[raddr1];
assign rdata2 = registers[raddr2];
always@(posedge clk_n) begin
  if(wea) begin
    registers[3'b0] <= 16'b0;
    if(waddr != 3'b0) begin
      registers[waddr] <= wdata;
    end
  end
end
endmodule