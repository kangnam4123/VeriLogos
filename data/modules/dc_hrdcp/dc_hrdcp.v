module dc_hrdcp ( 
   clkdec, 
   rstdec_x, 
   d_psum, 
   d_decdt, 
   d_hdtvh_dc_r, 
   d_dech_dt_r
);
input         clkdec;  
input         rstdec_x;
input  [20:0] d_psum;    
input  [15:0] d_decdt;    
input         d_hdtvh_dc_r;
output [15:0] d_dech_dt_r; 
wire          clkdec;    
wire          rstdec_x;  
wire   [20:0] d_psum;        
wire   [15:0] d_decdt;       
wire          d_hdtvh_dc_r;  
reg    [21:0] r_sum;         
reg     [7:0] r_sum1;        
reg    [15:0] d_dech_dt_r;   
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        r_sum <= 22'd0;
      end
    else
      begin
        r_sum <= {d_psum[20],d_psum} + 22'h000080;
      end
  end
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        r_sum1 <= 8'd0;
      end
    else
      begin
        if (r_sum[21] == 1'b1)
          begin
            r_sum1 <= 8'd0;
          end
        else if (r_sum[21:16] != 6'd0)
          begin
            r_sum1 <= r_sum[7:0];
          end
        else
          begin
            r_sum1 <= r_sum[15:8];
          end
      end
  end
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        d_dech_dt_r <= 16'd0;
      end
    else
      begin
        if (d_hdtvh_dc_r == 1'b0)
          begin
            d_dech_dt_r <= d_decdt;
          end
        else
          begin
            d_dech_dt_r <= {r_sum1,8'd0};
          end
      end
  end
endmodule