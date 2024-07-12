module async_cmp #(
  parameter C_DEPTH_BITS = 4,
  parameter N = C_DEPTH_BITS-1
)
(
	input WR_RST,
	input WR_CLK,
	input RD_RST,
	input RD_CLK,
	input RD_VALID,
	input WR_VALID,
	output EMPTY, 
	output FULL, 
	input [C_DEPTH_BITS-1:0] WR_PTR, 
	input [C_DEPTH_BITS-1:0] RD_PTR, 
	input [C_DEPTH_BITS-1:0] WR_PTR_P1, 
	input [C_DEPTH_BITS-1:0] RD_PTR_P1
);
reg				rDir=0;
wire			wDirSet = (  (WR_PTR[N]^RD_PTR[N-1]) & ~(WR_PTR[N-1]^RD_PTR[N]));
wire			wDirClr = ((~(WR_PTR[N]^RD_PTR[N-1]) &  (WR_PTR[N-1]^RD_PTR[N])) | WR_RST);
reg				rRdValid=0;
reg				rEmpty=1;
reg				rFull=0;
wire			wATBEmpty = ((WR_PTR == RD_PTR_P1) && (RD_VALID | rRdValid));
wire			wATBFull = ((WR_PTR_P1 == RD_PTR) && WR_VALID);
wire			wEmpty = ((WR_PTR == RD_PTR) && !rDir);
wire			wFull = ((WR_PTR == RD_PTR) && rDir);
assign EMPTY = wATBEmpty || rEmpty;
assign FULL  = wATBFull || rFull;
always @(posedge wDirSet or posedge wDirClr)
if (wDirClr) 
	rDir <= 1'b0;
else
	rDir <= 1'b1;
always @(posedge RD_CLK) begin
	rEmpty <= (RD_RST ? 1'd1 : wEmpty);
	rRdValid <= (RD_RST ? 1'd0 : RD_VALID);
end
always @(posedge WR_CLK) begin
	rFull <= (WR_RST ? 1'd0 : wFull);
end
endmodule