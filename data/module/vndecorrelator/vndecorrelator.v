module vndecorrelator(
                      input wire  clk,
                      input wire  reset_n,
                      input wire  data_in,
                      input wire  syn_in,
                      output wire data_out,
                      output wire syn_out
                     );
  parameter CTRL_IDLE = 1'b0;
  parameter CTRL_BITS = 1'b1;
  reg          data_in_reg;
  reg          data_in_we;
  reg          data_out_reg;
  reg          data_out_we;
  reg          syn_out_reg;
  reg          syn_out_new;
  reg          vndecorr_ctrl_reg;
  reg          vndecorr_ctrl_new;
  reg          vndecorr_ctrl_we;
  assign data_out = data_out_reg;
  assign syn_out  = syn_out_reg;
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        begin
          data_in_reg       <= 1'b0;
          data_out_reg      <= 1'b0;
          syn_out_reg       <= 1'b0;
          vndecorr_ctrl_reg <= CTRL_IDLE;
        end
      else
        begin
          syn_out_reg <= syn_out_new;
          if (data_in_we)
            begin
              data_in_reg <= data_in;
            end
          if (data_out_we)
            begin
              data_out_reg <= data_in;
            end
          if (vndecorr_ctrl_we)
            begin
              vndecorr_ctrl_reg <= vndecorr_ctrl_new;
            end
        end
    end 
  always @*
    begin : vndecorr_logic
      data_in_we        = 1'b0;
      data_out_we       = 1'b0;
      syn_out_new       = 1'b0;
      vndecorr_ctrl_new = CTRL_IDLE;
      vndecorr_ctrl_we  = 1'b0;
      case (vndecorr_ctrl_reg)
        CTRL_IDLE:
          begin
            if (syn_in)
              begin
                data_in_we        = 1'b1;
                vndecorr_ctrl_new = CTRL_BITS;
                vndecorr_ctrl_we  = 1'b1;
              end
          end
        CTRL_BITS:
          begin
            if (syn_in)
              begin
                if (data_in != data_in_reg)
                  begin
                    data_out_we = 1'b1;
                    syn_out_new = 1'b1;
                  end
                vndecorr_ctrl_new = CTRL_IDLE;
                vndecorr_ctrl_we  = 1'b1;
              end
          end
      endcase 
    end 
endmodule