module uc_hlsel(
  clkdec,
  rstdec_x,
  u_vyen_d1_r,
  u_vcen_d1_r,
  u_hyen_r,
  u_hcen_r,
  u_hdt_r,
  u_sdtvdth_r,
  u_hdtvhh_r,
  u_hopstp_r,
  u_ref1dt_r,
  u_ref1yen_r,
  u_ref1cen_r
  );
  input         clkdec;         
  input         rstdec_x;       
  input         u_vyen_d1_r;     
  input         u_vcen_d1_r;     
  input         u_hyen_r;        
  input         u_hcen_r;        
  input [15:0]  u_hdt_r;         
  input [15:0]  u_sdtvdth_r;     
  input         u_hdtvhh_r;      
  input         u_hopstp_r;      
  output [15:0] u_ref1dt_r;      
  output        u_ref1yen_r;     
  output        u_ref1cen_r;     
  wire          u_vyen_d1_r;          
  wire          u_vcen_d1_r;          
  wire          u_hyen_r;             
  wire          u_hcen_r;             
  wire [15:0]   u_hdt_r;              
  wire [15:0]   u_sdtvdth_r;          
  wire          u_hdtvhh_r;           
  wire          u_hopstp_r;           
  reg [15:0]    u_ref1dt_r;           
  reg           u_ref1yen_r;          
  reg           u_ref1cen_r;          
  reg [6:0]     u_hyen_dly_r,         
                u_hcen_dly_r;         
  always @(posedge clkdec or negedge rstdec_x) begin
    if ( !rstdec_x ) begin
      u_hyen_dly_r <= 7'b0;
      u_hcen_dly_r <= 7'b0;
    end
    else begin
      u_hyen_dly_r <= {u_hyen_dly_r[5:0],u_hyen_r};
      u_hcen_dly_r <= {u_hcen_dly_r[5:0],u_hcen_r};
    end
  end
  always @(posedge clkdec or negedge rstdec_x) begin
    if ( !rstdec_x ) begin
      u_ref1dt_r  <= 16'b0;
      u_ref1yen_r <= 1'b0;
      u_ref1cen_r <= 1'b0;
    end
    else if( u_hdtvhh_r ) begin
      u_ref1dt_r  <= u_hdt_r;
      u_ref1yen_r <= u_hyen_dly_r[6];
      u_ref1cen_r <= u_hcen_dly_r[6];
    end
    else begin
      u_ref1dt_r  <= u_sdtvdth_r & {16{u_hopstp_r}};
      u_ref1yen_r <= u_vyen_d1_r & u_hopstp_r;
      u_ref1cen_r <= u_vcen_d1_r & u_hopstp_r;
    end
  end
endmodule