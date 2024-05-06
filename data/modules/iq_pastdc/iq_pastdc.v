module iq_pastdc(
  clkdec,
  rstdec_x,
  slcsf_reg,
  iyxst_reg,
  icbst_reg,
  icrst_reg,
  ybr0_reg,
  cbblk_reg,
  crblk_reg,
  pintr_reg,
  smd2,
  iqpastdc_reg
  );
  input clkdec;  
  input rstdec_x;
  input slcsf_reg;    
  input iyxst_reg;    
  input icbst_reg;    
  input icrst_reg;    
  input ybr0_reg;     
  input cbblk_reg;    
  input crblk_reg;    
  input pintr_reg;    
  input [11:0] smd2;  
  output [15:0] iqpastdc_reg; 
  reg [11:0] iqydc_reg;     
  reg [11:0] iqbdc_reg;     
  reg [11:0] iqrdc_reg;     
  reg [11:0] iqpdc;         
  reg [15:0] iqpastdc_reg;  
  always @(posedge clkdec or negedge rstdec_x)
    if (!rstdec_x)
      iqydc_reg <= 12'h000;
    else begin
      if (iyxst_reg == 1'b1)
        iqydc_reg <= smd2;
      else
        iqydc_reg <= iqydc_reg;
    end
  always @(posedge clkdec or negedge rstdec_x)
    if (!rstdec_x)
      iqbdc_reg <= 12'h000;
    else begin
      if (icbst_reg == 1'b1)
        iqbdc_reg <= smd2;
      else
        iqbdc_reg <= iqbdc_reg;
    end
  always @(posedge clkdec or negedge rstdec_x)
    if (!rstdec_x)
      iqrdc_reg <= 12'h000;
    else begin
      if (icrst_reg == 1'b1)
        iqrdc_reg <= smd2;
      else
        iqrdc_reg <= iqrdc_reg;
      end
  always @(slcsf_reg or pintr_reg or cbblk_reg or crblk_reg or 
           ybr0_reg or iqrdc_reg or iqbdc_reg or iqydc_reg )
    if (ybr0_reg == 1'b1 && ( slcsf_reg == 1'b1 || pintr_reg == 1'b0 ))
      iqpdc = 12'd1024;
    else if ( crblk_reg == 1'b1)
      iqpdc = iqrdc_reg;
    else if ( cbblk_reg == 1'b1)
      iqpdc = iqbdc_reg;
    else
    iqpdc = iqydc_reg;
  always @(posedge clkdec)
    iqpastdc_reg <= {{4{iqpdc[11]}},iqpdc};
endmodule