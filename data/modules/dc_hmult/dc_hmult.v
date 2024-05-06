module dc_hmult ( 
   clkdec, 
   rstdec_x, 
   d_pix, 
   d_coef, 
   d_ppro
);
input         clkdec;     
input         rstdec_x;   
input  [7:0]  d_pix;    
input  [8:0]  d_coef;   
output [16:0] d_ppro;   
wire clkdec;              
wire rstdec_x;            
wire [7:0] d_pix;             
wire [8:0] d_coef;            
reg [16:0] d_ppro;            
reg [17:0] d_ppro1;           
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        d_ppro1    <= 18'd0;
      end
    else
      begin
        d_ppro1    <= {10'd0,d_pix} * {{9{d_coef[8]}},d_coef};
      end
  end
always @(posedge clkdec or negedge rstdec_x) 
  begin
    if (!rstdec_x)
      begin
        d_ppro    <= 17'd0;
      end
    else
      begin
        d_ppro    <= {(d_ppro1[17]&d_ppro1[16]),d_ppro1[15:0]};
      end
  end
endmodule