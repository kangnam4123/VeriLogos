module ctspgen (
    clkdec,               
    rstdec_x,             
    c_phdet_r,            
    c_mbaidet_s,          
    c_picend_ena_r,       
    c_inipl_r_s           
  );
    input        clkdec;     
    input        rstdec_x;   
    input        c_phdet_r;    
    input        c_mbaidet_s;  
    input        c_picend_ena_r;
    output       c_inipl_r_s;  
    reg          c_inipl_r_s;          
    reg          c_inipl_pre_flg_r;
    reg          c_inipl_pre_flg_d1_r;
    wire         c_ph_mbai_det;
    assign c_ph_mbai_det =  c_phdet_r & c_mbaidet_s;
    always @(posedge clkdec or negedge rstdec_x)
      begin
        if (!rstdec_x)  
          begin
            c_inipl_pre_flg_r  <= 1'b0;
          end
        else if (c_ph_mbai_det)
          begin
            c_inipl_pre_flg_r  <= 1'b1;
          end
        else if (c_inipl_pre_flg_r && !c_picend_ena_r)
          begin
            c_inipl_pre_flg_r  <= 1'b0;
          end
      end
    always @(posedge clkdec or negedge rstdec_x)
      begin
        if (!rstdec_x)
          begin
            c_inipl_pre_flg_d1_r  <= 1'b0;
          end
        else
          begin
            c_inipl_pre_flg_d1_r  <= c_inipl_pre_flg_r;
          end
      end
    always @(posedge clkdec or negedge rstdec_x)
      begin
        if (!rstdec_x)  
          begin
            c_inipl_r_s  <= 1'b0;
          end
        else
          begin
            c_inipl_r_s  <= (c_inipl_pre_flg_d1_r & ~c_inipl_pre_flg_r);
          end
      end
endmodule