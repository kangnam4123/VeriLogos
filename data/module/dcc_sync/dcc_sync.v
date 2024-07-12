module dcc_sync (
                 sclk,
                 dcc_en, 
                 finish_dcc, 
                 dcc_vld,    
                 dcc_data, 
                 statistics_dv, 
                 statistics_do 
                 );
input         sclk, dcc_en, finish_dcc,dcc_vld;
input  [15:0] dcc_data;
output        statistics_dv;
output [15:0] statistics_do;
reg    [15:0] statistics_do;
reg           statistics_we;
reg           statistics_dv;
reg           dcc_run;
reg           dcc_finishing;
reg           skip16; 
reg    [ 4:0] dcc_cntr;
always @ (posedge sclk) begin
  dcc_run <= dcc_en;
  statistics_we <= dcc_run && dcc_vld && !statistics_we;
  statistics_do[15:0] <= statistics_we?dcc_data[15:0]:16'h0;
  statistics_dv <= statistics_we || dcc_finishing;
  skip16 <= finish_dcc && (statistics_dv?(dcc_cntr[3:0]==4'hf):(dcc_cntr[3:0]==4'h0) ); 
  if (!dcc_run)           dcc_cntr[3:0] <= 4'h0;
  else if (statistics_dv) dcc_cntr[3:0] <= dcc_cntr[3:0]+1; 
  dcc_cntr[4]   <= dcc_run && ((dcc_finishing && ((dcc_cntr[3:0]==4'hf)^dcc_cntr[4]) || skip16));
  dcc_finishing <= dcc_run && (finish_dcc   || (dcc_finishing && (dcc_cntr[4:1]!=4'hf)));
end
endmodule