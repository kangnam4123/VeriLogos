module stable_match_core
#(
  parameter Kw =8,
  parameter Km =8,
  parameter M  =8,
  parameter W  =8
)
(
  clk,
  rst,
  state,
  mIndex,
  wIndex,
  m,
  w,
  mPrefMatrix_raddr,
  mPrefMatrix_rdata,
  pc_addr,
  pc_wdata,
  pc_wen,
  pc_rdata,
  wIsMatch_addr,
  wIsMatch_wdata,
  wIsMatch_wen,
  wIsMatch_rdata,
  matchListMatrix_addr,
  matchListMatrix_wdata,
  matchListMatrix_wen,
  matchListMatrix_rdata,
  wPref_rev_Matrix_raddr1,
  wPref_rev_Matrix_rdata1,
  wPref_rev_Matrix_raddr2,
  wPref_rev_Matrix_rdata2,
  mIsMatch_waddr1,
  mIsMatch_wdata1,
  mIsMatch_wen1,
  mIsMatch_waddr2,
  mIsMatch_wdata2,
  mIsMatch_wen2,
  mIsMatch_raddr,
  mIsMatch_rdata
);
  function integer log2;
    input [31:0] value;
    reg [31:0] temp;
  begin
    temp = value - 1;
    for (log2=0; temp>0; log2=log2+1)
      temp = temp>>1;
  end
  endfunction
  localparam logM = log2(M);
  localparam logW = log2(W);
  localparam logKm = log2(Km);
  localparam logKw = log2(Kw);
  localparam state_select_m=0;
  localparam state_select_w=2;
  localparam state_wait_w = 3;
  localparam state_do_proposal = 4;
  input clk,rst;
  output reg [logM-1:0] mIndex;
  output reg [logW-1:0] wIndex;
  output reg [2:0] state;
  output reg [logM-1:0] m;
  output reg [logW-1:0] w;
  output [logKm-1:0] mPrefMatrix_raddr;
  input [logW-1:0]   mPrefMatrix_rdata;
  output [logM-1:0]  pc_addr;
  output [logKm:0]   pc_wdata;
  output pc_wen;
  input [logKm:0]  pc_rdata;
  output [logW-1:0] wIsMatch_addr;
  output wIsMatch_wdata;
  output wIsMatch_wen;
  input wIsMatch_rdata;
  output [logW-1:0] matchListMatrix_addr;
  output [logM:0] matchListMatrix_wdata;
  output matchListMatrix_wen;
  input [logM:0] matchListMatrix_rdata;
  output [logM-1:0]   wPref_rev_Matrix_raddr1;
  input [logKw-1:0]  wPref_rev_Matrix_rdata1;
  output [logM-1:0]   wPref_rev_Matrix_raddr2;
  input [logKw-1:0]  wPref_rev_Matrix_rdata2;
  output [logM-1:0] mIsMatch_waddr1;
  output mIsMatch_wdata1;
  output mIsMatch_wen1;
  output [logM-1:0] mIsMatch_waddr2;
  output mIsMatch_wdata2;
  output mIsMatch_wen2;
  output [logM-1:0] mIsMatch_raddr;
  input mIsMatch_rdata;
  reg [2:0] nState;
  wire [logKm:0] pc_mIndex;
  wire [logM-1:0] m_assigned;
  wire better;
  wire propose;
  wire can_propose;
  assign m_assigned = matchListMatrix_rdata;
  assign better = (wPref_rev_Matrix_rdata1 < wPref_rev_Matrix_rdata2);
  assign can_propose = |pc_mIndex & ~mIsMatch_rdata;
  assign mPrefMatrix_raddr = Km-pc_mIndex;
  assign pc_addr = mIndex;
  assign pc_wdata = pc_mIndex-1;
  assign pc_wen = state==state_select_m && can_propose;
  assign pc_mIndex = pc_rdata;
  assign mIsMatch_waddr1 = m;
  assign mIsMatch_wdata1 = 1'b1;
  assign mIsMatch_wen1 = (state==state_do_proposal) &&
    (wIsMatch_rdata==0 || (wIsMatch_rdata!=0 && better));
  assign mIsMatch_waddr2 = m_assigned;
  assign mIsMatch_wdata2 = 1'b0;
  assign mIsMatch_wen2 = (state==state_do_proposal) &&
    (wIsMatch_rdata!=0 && better);
  assign mIsMatch_raddr = mIndex;
  assign wIsMatch_addr = w;
  assign wIsMatch_wdata = 1'b1;
  assign wIsMatch_wen = state==state_do_proposal && wIsMatch_rdata;
  assign matchListMatrix_addr = w;
  assign matchListMatrix_wdata = m;
  assign matchListMatrix_wen = (state==state_do_proposal) &&
    (wIsMatch_rdata==0 || (wIsMatch_rdata!=0 && better));
  assign wPref_rev_Matrix_raddr1 = m;
  assign wPref_rev_Matrix_raddr2 = m_assigned;
  always@(*) begin
    nState = state_select_m;
    case (state)
      state_select_m: begin
        if(can_propose)
          nState = state_wait_w;
        else
          nState = state_select_m;
      end
      state_wait_w: begin
        if (wIndex + 1 == w) begin
          nState=state_do_proposal;
        end else begin
          nState=state_wait_w;
        end
      end
      state_do_proposal: begin
        nState=state_select_m;
      end
      default: begin
        nState=state_select_m;
      end
    endcase
  end
  integer k;
  always@(posedge clk or posedge rst) begin
    if(rst) begin
      m<=0;
      w<=0;
      mIndex<=0;
      wIndex<=0;
      state<=state_select_m;
    end else begin
      state <= nState;
      mIndex <= (mIndex+1);
      wIndex <= (wIndex+1);
      if (state==state_select_m) begin
        m <= mIndex;
        w <= mPrefMatrix_rdata;
      end
    end
  end
endmodule