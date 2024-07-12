module ssi_sfifo
  #
  (
   parameter WIDTH = 32,
   parameter DEPTH = 8,
   parameter DLOG2 = 3,
   parameter AFULL = 3
   )
  (
   input  [WIDTH-1:0]     data,
   input                  wrreq,
   input                  rdreq,
   input                  clock,
   input                  aclr,
   output reg [WIDTH-1:0] q,
   output                 full,
   output                 empty,
   output reg [DLOG2-1:0] usedw,
   output                 almost_full
   );
  reg [WIDTH-1:0]         ram[DEPTH-1:0];
  reg [DLOG2-1:0]         wr_addr;
  reg [DLOG2-1:0]         rd_addr;
  always @(posedge clock, posedge aclr)
    if (aclr) begin
      usedw   <= 'b0;
      wr_addr <= 'b0;
      rd_addr <= 'b0;
      q       <= 'b0;
    end else begin
      case ({wrreq, rdreq})
        2'b10: usedw <= usedw + 8'h1;
        2'b01: usedw <= usedw - 8'h1;
      endcase 
      if (wrreq) ram[wr_addr] <= data;
      if (wrreq) wr_addr <= wr_addr + 8'h1;
      if (rdreq) begin
        rd_addr <= rd_addr + 8'h1;
        q       <= ram[rd_addr];
      end
    end 
  assign full = &usedw;
  assign empty = ~|usedw;
  assign almost_full = usedw > AFULL;
endmodule