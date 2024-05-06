module uc_vtsel(
  clkdec,
  rstdec_x,
  u_dt_r,
  u_yen_r,
  u_cen_r,
  u_refv_ysngl_r,
  u_refv_csngl_r,
  u_sdtvdt_r,
  u_syen_r,
  u_scen_r,
  u_hdtvh_r,
  u_ref1v_dt_r,
  u_ref1v_yen_r,
  u_ref1v_cen_r,
  u_ref1v_ysngl_r,
  u_ref1v_csngl_r
  );
  input         clkdec;     
  input         rstdec_x;   
  input [15:0]  u_dt_r;         
  input         u_yen_r;        
  input         u_cen_r;        
  input         u_refv_ysngl_r; 
  input         u_refv_csngl_r; 
  input [15:0]  u_sdtvdt_r;     
  input         u_syen_r;       
  input         u_scen_r;       
  input         u_hdtvh_r;      
  output [15:0] u_ref1v_dt_r;   
  output        u_ref1v_yen_r;  
  output        u_ref1v_cen_r;  
  output        u_ref1v_ysngl_r;
  output        u_ref1v_csngl_r;
  wire [15:0]   u_dt_r;               
  wire          u_yen_r;              
  wire          u_cen_r;              
  wire          u_refv_ysngl_r;       
  wire          u_refv_csngl_r;       
  wire [15:0]   u_sdtvdt_r;           
  wire          u_syen_r;             
  wire          u_scen_r;             
  wire          u_hdtvh_r;            
  reg [15:0]    u_ref1v_dt_r;         
  reg           u_ref1v_yen_r;        
  reg           u_ref1v_cen_r;        
  reg           u_ref1v_ysngl_r;      
  reg           u_ref1v_csngl_r;      
  always @(posedge clkdec or negedge rstdec_x) begin
    if ( !rstdec_x ) begin
      u_ref1v_dt_r     <= 16'b0;
      u_ref1v_yen_r    <= 1'b0;
      u_ref1v_cen_r    <= 1'b0;
      u_ref1v_ysngl_r  <= 1'b0;
      u_ref1v_csngl_r  <= 1'b0;
    end
    else if( u_hdtvh_r ) begin
      u_ref1v_dt_r     <= u_dt_r;
      u_ref1v_yen_r    <= u_yen_r;
      u_ref1v_cen_r    <= u_cen_r;
      u_ref1v_ysngl_r  <= u_refv_ysngl_r;
      u_ref1v_csngl_r  <= u_refv_csngl_r;
    end
    else begin
      u_ref1v_dt_r     <= u_sdtvdt_r;
      u_ref1v_yen_r    <= u_syen_r;
      u_ref1v_cen_r    <= u_scen_r;
      u_ref1v_ysngl_r  <= 1'b0;
      u_ref1v_csngl_r  <= 1'b0;
    end
  end
endmodule