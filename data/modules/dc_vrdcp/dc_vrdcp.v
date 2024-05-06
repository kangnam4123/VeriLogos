module dc_vrdcp ( 
   clkdec, 
   rstdec_x, 
   d_psum, 
   d_vflt_dout
);
input         clkdec; 
input         rstdec_x;
input  [19:0] d_psum;      
output [7:0]  d_vflt_dout; 
wire          clkdec;  
wire          rstdec_x;
wire   [19:0] d_psum;      
reg    [7:0]  d_vflt_dout; 
reg    [20:0] r_sum;       
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        r_sum <= 21'd0;
      end
    else
      begin
        r_sum <= {d_psum[19],d_psum} + 21'h80;
      end
  end
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        d_vflt_dout <= 8'd0;
      end
    else
      begin
        if (r_sum[20] == 1'b1)
          begin
            d_vflt_dout <= 8'd0;
          end
        else if (r_sum[20:16] != 5'd0)
          begin
            d_vflt_dout <= r_sum[7:0];
          end
        else 
          begin
            d_vflt_dout <= r_sum[15:8];
          end
      end
  end
endmodule