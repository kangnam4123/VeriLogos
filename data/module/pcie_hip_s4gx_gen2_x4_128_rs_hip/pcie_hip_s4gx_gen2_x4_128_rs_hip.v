module pcie_hip_s4gx_gen2_x4_128_rs_hip (
                                           dlup_exit,
                                           hotrst_exit,
                                           l2_exit,
                                           ltssm,
                                           npor,
                                           pld_clk,
                                           test_sim,
                                           app_rstn,
                                           crst,
                                           srst
                                        )
;
  output           app_rstn;
  output           crst;
  output           srst;
  input            dlup_exit;
  input            hotrst_exit;
  input            l2_exit;
  input   [  4: 0] ltssm;
  input            npor;
  input            pld_clk;
  input            test_sim;
  reg              any_rstn_r ;
  reg              any_rstn_rr ;
  reg              app_rstn;
  reg              app_rstn0;
  reg              crst;
  reg              crst0;
  reg     [  4: 0] dl_ltssm_r;
  reg              dlup_exit_r;
  reg              exits_r;
  reg              hotrst_exit_r;
  reg              l2_exit_r;
  wire             otb0;
  wire             otb1;
  reg     [ 10: 0] rsnt_cntn;
  reg              srst;
  reg              srst0;
  assign otb0 = 1'b0;
  assign otb1 = 1'b1;
  always @(posedge pld_clk or negedge any_rstn_rr)
    begin
      if (any_rstn_rr == 0)
        begin
          dlup_exit_r <= otb1;
          hotrst_exit_r <= otb1;
          l2_exit_r <= otb1;
          exits_r <= otb0;
        end
      else 
        begin
          dlup_exit_r <= dlup_exit;
          hotrst_exit_r <= hotrst_exit;
          l2_exit_r <= l2_exit;
          exits_r <= (l2_exit_r == 1'b0) | (hotrst_exit_r == 1'b0) | (dlup_exit_r == 1'b0) | (dl_ltssm_r == 5'h10);
        end
    end
  always @(posedge pld_clk or negedge any_rstn_rr)
    begin
      if (any_rstn_rr == 0)
          dl_ltssm_r <= 0;
      else 
        dl_ltssm_r <= ltssm;
    end
  always @(posedge pld_clk or negedge npor)
    begin
      if (npor == 0)
        begin
          any_rstn_r <= 0;
          any_rstn_rr <= 0;
        end
      else 
        begin
          any_rstn_r <= 1;
          any_rstn_rr <= any_rstn_r;
        end
    end
  always @(posedge pld_clk or negedge any_rstn_rr)
    begin
      if (any_rstn_rr == 0)
          rsnt_cntn <= 0;
      else if (exits_r == 1'b1)
          rsnt_cntn <= 11'h3f0;
      else if (rsnt_cntn != 11'd1024)
          rsnt_cntn <= rsnt_cntn + 1;
    end
  always @(posedge pld_clk or negedge any_rstn_rr)
    begin
      if (any_rstn_rr == 0)
        begin
          app_rstn0 <= 0;
          srst0 <= 1;
          crst0 <= 1;
        end
      else if (exits_r == 1'b1)
        begin
          srst0 <= 1;
          crst0 <= 1;
          app_rstn0 <= 0;
        end
      else 
      if ((test_sim == 1'b1) & (rsnt_cntn >= 11'd32))
        begin
          srst0 <= 0;
          crst0 <= 0;
          app_rstn0 <= 1;
        end
      else 
      if (rsnt_cntn == 11'd1024)
        begin
          srst0 <= 0;
          crst0 <= 0;
          app_rstn0 <= 1;
        end
    end
  always @(posedge pld_clk or negedge any_rstn_rr)
    begin
      if (any_rstn_rr == 0)
        begin
          app_rstn <= 0;
          srst <= 1;
          crst <= 1;
        end
      else 
        begin
          app_rstn <= app_rstn0;
          srst <= srst0;
          crst <= crst0;
        end
    end
endmodule