module async_fifo_ram (wrclk, rdclk, wrenb, wrptr, wrdata, rdenb, rdptr, rddata);
parameter ASYNC_FIFO_MAXINDEX = 4;
parameter ASYNC_FIFO_MAXDATA = 31;
input wrclk, rdclk;
input wrenb, rdenb;
input [ASYNC_FIFO_MAXINDEX:0] wrptr, rdptr;
input [ASYNC_FIFO_MAXDATA:0] wrdata;
output [ASYNC_FIFO_MAXDATA:0] rddata;
wire #1 dly_wrenb = wrenb;
wire [ASYNC_FIFO_MAXINDEX:0] #1 dly_wrptr = wrptr;
wire [ASYNC_FIFO_MAXDATA:0] #1 dly_wrdata = wrdata;
wire #1 dly_rdenb = rdenb;
wire [ASYNC_FIFO_MAXINDEX:0] #1 dly_rdptr = rdptr;
reg [ASYNC_FIFO_MAXDATA:0] mem[0:(1<<(ASYNC_FIFO_MAXINDEX+1))-1];
reg [ASYNC_FIFO_MAXINDEX:0] rdptr_reg;
assign rddata = mem[rdptr_reg];
always @ (posedge wrclk)
begin
  if (dly_wrenb) mem[dly_wrptr] = dly_wrdata;
end
always @ (posedge rdclk)
begin
  rdptr_reg = dly_rdptr;
end
endmodule