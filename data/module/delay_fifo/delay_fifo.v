module delay_fifo #(
  parameter DLY = 3,	
  parameter DW = 32
)(
  input  wire          clk,
  input  wire          rst,
  input  wire          sti_valid,
  input  wire [DW-1:0] sti_data,
  output wire          sto_valid,
  output wire [DW-1:0] sto_data
);
reg [DLY*(DW+1)-1:0] mem;
always @(posedge clk)
mem <= {mem, {sti_valid, sti_data}};
assign {sto_valid, sto_data} = mem[(DLY-1)*(DW+1)+:(DW+1)]; 
endmodule