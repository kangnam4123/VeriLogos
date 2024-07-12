module mor1kx_simple_dpram_sclk
  #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter CLEAR_ON_INIT = 0,
    parameter ENABLE_BYPASS = 1
    )
   (
    input 		    clk,
    input [ADDR_WIDTH-1:0]  raddr,
    input 		    re,
    input [ADDR_WIDTH-1:0]  waddr,
    input 		    we,
    input [DATA_WIDTH-1:0]  din,
    output [DATA_WIDTH-1:0] dout
    );
   reg [DATA_WIDTH-1:0]     mem[(1<<ADDR_WIDTH)-1:0];
   reg [DATA_WIDTH-1:0]     rdata;
generate
if(CLEAR_ON_INIT) begin :clear_on_init
   integer 		    idx;
   initial
     for(idx=0; idx < (1<<ADDR_WIDTH); idx=idx+1)
       mem[idx] = {DATA_WIDTH{1'b0}};
end
endgenerate
generate
if (ENABLE_BYPASS) begin : bypass_gen
   reg [DATA_WIDTH-1:0]     din_r;
   reg 			    bypass;
   assign dout = bypass ? din_r : rdata;
   always @(posedge clk)
     if (re)
       din_r <= din;
   always @(posedge clk)
     if (waddr == raddr && we && re)
       bypass <= 1;
     else if (re)
       bypass <= 0;
end else begin
   assign dout = rdata;
end
endgenerate
   always @(posedge clk) begin
      if (we)
	mem[waddr] <= din;
      if (re)
	rdata <= mem[raddr];
   end
endmodule