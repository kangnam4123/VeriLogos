module calc_speed (clk,             
                   en_in,           
                   process,         
                   inc_dec,         
                   inc,             
                   dec,             
                   enc_period_curr, 
                   dir_last,        
                   enc_period_last, 
                   dir_this,        
                   enc_period_this  
                   );
 parameter IGNORE_EN=1;
 input         clk;             
 input         en_in;           
 input         process;         
 input         inc_dec;         
 input         inc;             
 input         dec;             
 input   [4:0] enc_period_curr; 
 input         dir_last;        
 input   [4:0] enc_period_last; 
 output        dir_this;        
 output  [4:0] enc_period_this; 
 wire          en=(IGNORE_EN)?1'b1:en_in; 
 wire          dir_this;
 wire    [4:0] enc_period_this;
 wire    [5:0] diff;
 assign dir_this=              en & (inc_dec?dec:dir_last);
 assign diff[5:0]=            {1'b0,enc_period_curr}-{1'b0,enc_period_last};
 assign enc_period_this[4:0]= en ? ((diff[5] && !inc_dec)?enc_period_last[4:0]:enc_period_curr[4:0]):5'b0;
endmodule