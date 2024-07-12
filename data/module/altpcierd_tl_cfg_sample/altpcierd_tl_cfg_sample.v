module altpcierd_tl_cfg_sample #(
   parameter HIP_SV          = 0
   )(
  input                pld_clk,           
  input                rstn,
  input       [  3: 0] tl_cfg_add,        
  input       [ 31: 0] tl_cfg_ctl,        
  input                tl_cfg_ctl_wr,     
  input       [ 52: 0] tl_cfg_sts,        
  input                tl_cfg_sts_wr,     
  output reg  [ 12: 0] cfg_busdev,        
  output reg  [ 31: 0] cfg_devcsr,        
  output reg  [ 31: 0] cfg_linkcsr,       
  output reg  [31:0]   cfg_prmcsr,
  output reg [19:0] cfg_io_bas,
  output reg [19:0] cfg_io_lim,
  output reg [11:0] cfg_np_bas,
  output reg [11:0] cfg_np_lim,
  output reg [43:0] cfg_pr_bas,
  output reg [43:0] cfg_pr_lim,
  output reg [23:0]    cfg_tcvcmap,
  output reg [15:0]    cfg_msicsr
);
  reg              tl_cfg_ctl_wr_r;
  reg              tl_cfg_ctl_wr_rr;
  reg              tl_cfg_ctl_wr_rrr;
  reg              tl_cfg_sts_wr_r;
  reg              tl_cfg_sts_wr_rr;
  reg              tl_cfg_sts_wr_rrr;
always @(posedge pld_clk or negedge rstn) begin
    if (rstn == 0) begin
        tl_cfg_ctl_wr_r   <= 0;
        tl_cfg_ctl_wr_rr  <= 0;
        tl_cfg_ctl_wr_rrr <= 0;
        tl_cfg_sts_wr_r   <= 0;
        tl_cfg_sts_wr_rr  <= 0;
        tl_cfg_sts_wr_rrr <= 0;
    end
    else  begin
        tl_cfg_ctl_wr_r   <= tl_cfg_ctl_wr;
        tl_cfg_ctl_wr_rr  <= tl_cfg_ctl_wr_r;
        tl_cfg_ctl_wr_rrr <= tl_cfg_ctl_wr_rr;
        tl_cfg_sts_wr_r   <= tl_cfg_sts_wr;
        tl_cfg_sts_wr_rr  <= tl_cfg_sts_wr_r;
        tl_cfg_sts_wr_rrr <= tl_cfg_sts_wr_rr;
    end
end
always @(posedge pld_clk or negedge rstn) begin
   if (rstn == 0) begin
       cfg_busdev  <= 16'h0;
       cfg_devcsr  <= 32'h0;
       cfg_linkcsr <= 32'h0;
       cfg_msicsr  <= 16'h0;
       cfg_tcvcmap <= 24'h0;
       cfg_prmcsr  <= 32'h0;
       cfg_io_bas  <= 20'h0;
       cfg_io_lim  <= 20'h0;
       cfg_np_bas  <= 12'h0;
       cfg_np_lim  <= 12'h0;
       cfg_pr_bas  <= 44'h0;
       cfg_pr_lim  <= 44'h0;
   end
   else  begin
       cfg_prmcsr[26:25] <= 2'h0;
       cfg_prmcsr[23:16] <= 8'h0;
       cfg_devcsr[31:20] <= 12'h0;
       if ((tl_cfg_sts_wr_rrr != tl_cfg_sts_wr_rr) || (HIP_SV==1)) begin
           cfg_devcsr[19 : 16] <= tl_cfg_sts[52 : 49];
           cfg_linkcsr[31:16]  <= tl_cfg_sts[46 : 31];
           cfg_prmcsr[31:27]   <= tl_cfg_sts[29:25];
           cfg_prmcsr[24]      <= tl_cfg_sts[24];
       end
       if ((tl_cfg_ctl_wr_rrr != tl_cfg_ctl_wr_rr) || (HIP_SV==1)) begin
           if (tl_cfg_add==4'h0)  cfg_devcsr[15:0]  <= tl_cfg_ctl[31:16];
           if (tl_cfg_add==4'h2)  cfg_linkcsr[15:0] <= tl_cfg_ctl[31:16];
           if (tl_cfg_add==4'h3)  cfg_prmcsr[15:0]  <= tl_cfg_ctl[23:8];
           if (tl_cfg_add==4'h5)  cfg_io_bas        <= tl_cfg_ctl[19:0];
           if (tl_cfg_add==4'h6)  cfg_io_lim        <= tl_cfg_ctl[19:0];
           if (tl_cfg_add==4'h7)  cfg_np_bas        <= tl_cfg_ctl[23:12];
           if (tl_cfg_add==4'h7)  cfg_np_lim        <= tl_cfg_ctl[11:0];
           if (tl_cfg_add==4'h8)  cfg_pr_bas[31:0]  <= tl_cfg_ctl[31:0];
           if (tl_cfg_add==4'h9)  cfg_pr_bas[43:32] <= tl_cfg_ctl[11:0];
           if (tl_cfg_add==4'hA)  cfg_pr_lim[31:0]  <= tl_cfg_ctl[31:0];
           if (tl_cfg_add==4'hB)  cfg_pr_lim[43:32] <= tl_cfg_ctl[11:0];
           if (tl_cfg_add==4'hD)  cfg_msicsr[15:0]  <= tl_cfg_ctl[15:0];
           if (tl_cfg_add==4'hE)  cfg_tcvcmap[23:0] <= tl_cfg_ctl[23:0];
           if (tl_cfg_add==4'hF)  cfg_busdev        <= tl_cfg_ctl[12:0];
       end
   end
end
endmodule